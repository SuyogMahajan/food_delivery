import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/data/controllers/popular_product_controller.dart';
import 'package:food_delivery/data/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../models/products_model.dart';
import '../../models/products_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  var scaleFactor = 0.8;
  var _height = 220;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        // print("Current value is "+_currPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
     GetBuilder<PopularProductController>(builder:(popularProducts) {
       return popularProducts.isLoaded ? Container(
         height: Dimensions.pageView,
         child: PageView.builder(
             controller: pageController,
             itemCount: popularProducts.popularProductList.length,
             itemBuilder: (context, position) {
               return _buildPageItem(position,popularProducts.popularProductList[position]);
             }),
       ) :CircularProgressIndicator(
         color: AppColors.mainColor,
       );
     }),
      GetBuilder<PopularProductController>(builder:(popularProducts) {
     return DotsIndicator(
    dotsCount: popularProducts.popularProductList.isEmpty ?1:popularProducts.popularProductList.length,
    position: _currPageValue,
    decorator: DotsDecorator(
    size: const Size.square(9.0),
    activeSize: const Size(18.0, 9.0),
    activeShape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30))),
    );
    }),
      SizedBox(
        height: Dimensions.height30,
      ),
      Container(
        margin: EdgeInsets.only(left: Dimensions.width30),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          BigText(text: "Recommended"),
          SizedBox(
            width: Dimensions.width10,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 3),
            child: BigText(text: ".", color: Colors.black26),
          ),
          SizedBox(
            width: Dimensions.width10,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 2),
            child: SmallText(
              text: "Food pairing",
            ),
          ),
        ]),
      ),
      GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
        return recommendedProduct.isLoaded ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recommendedProduct.recommendedProductList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                    left: Dimensions.height20,
                    right: Dimensions.height20,
                    bottom: Dimensions.height10),
                child: Row(
                  children: [
                    Container(
                      width: Dimensions.listViewImg,
                      height: Dimensions.listViewImg,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!))),
                    ),
                    Expanded(
                      child: Container(
                        height: Dimensions.listViewTextContSize,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                bottomRight:
                                Radius.circular(Dimensions.radius20)),
                            color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.only(left: Dimensions.width10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BigText(text: "Nutritious fruit meal in china"),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              SmallText(text: "With chinese characteristics"),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconAndTextWidget(
                                      icon: Icons.circle_sharp,
                                      text: "Normal",
                                      iconColor: AppColors.iconColor1),
                                  IconAndTextWidget(
                                      icon: Icons.location_on,
                                      text: "1.7km",
                                      iconColor: AppColors.mainColor),
                                  IconAndTextWidget(
                                      icon: Icons.access_time_rounded,
                                      text: "32min",
                                      iconColor: AppColors.iconColor2)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }) : CircularProgressIndicator(color: AppColors.mainColor,);
      },)
    ]);
  }

  Widget _buildPageItem(int index,ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();

    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          scaleFactor + (_currPageValue - index + 1) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(
                left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Color(0xff69c5df) : Color(0xff9294cc),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.BASE_URL +AppConstants.UPLOAD_URL+ popularProduct.img!))),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: EdgeInsets.only(
                    left: Dimensions.width30,
                    right: Dimensions.width30,
                    bottom: Dimensions.height30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xffe8e8e8),
                          offset: Offset(0, 5),
                          blurRadius: 5.0),
                      BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                      BoxShadow(color: Colors.white, offset: Offset(5, 0))
                    ]),
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height10, left: 15, right: 15),
                  child: AppColumn(text: popularProduct.name!,),
                ),
              ))
        ],
      ),
    );
  }
}
