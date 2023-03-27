import 'package:flutter/material.dart';
import 'package:food_delivery/data/controllers/cart_controller.dart';
import 'package:food_delivery/data/controllers/popular_product_controller.dart';
import 'package:food_delivery/main.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;

  PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          product.img!))),
            ),
          ),

          //icon widget
          Positioned(
            top: Dimensions.height50,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // back button
                GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios)),

                GetBuilder<PopularProductController>(builder: (controller) {
                  return
                  
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(7),
                            child: AppIcon(icon: Icons.shopping_cart_outlined),
                          ),
                          // controller.totalItems >= 1
                          //
                          //     ? Positioned(
                          //         right: 0,
                          //         top: 0,
                          //         child: AppIcon(
                          //           icon: Icons.circle,
                          //           size: 20,
                          //           backgroundColor: AppColors.mainColor,
                          //           iconColor: AppColors.mainColor,
                          //         ))
                          //     : Container(),
                          //
                          // controller.totalItems >= 1
                          //     ? Positioned(
                          //     right: 3,
                          //     top: 3,
                          //     child:
                          //     BigText(
                          //       text: controller.totalItems.toString(),color: Colors.white,size: 12,
                          //     )
                          // )
                          //     : Container()
                          if (controller.totalItems >= 1)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding:EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.mainColor),
                                child: BigText(
                                  text: controller.totalItems.toString(),
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                        ],
                  ),
                    );
                })
              ],
            ),
          ),

          //introduction of food
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 30,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20)),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                    text: product.name!,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  BigText(text: "Introduce"),

                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  //expandable text widget
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                        text: product.description!,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                right: Dimensions.width20,
                left: Dimensions.width20,
                bottom: Dimensions.height30),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      bottom: Dimensions.height15,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      SizedBox(width: Dimensions.width10 / 2),
                      BigText(text: popularProduct.inCartItems.toString()),
                      SizedBox(width: Dimensions.width10 / 2),
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height15,
                        bottom: Dimensions.height15,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                      child: BigText(
                        text: "\$ ${product.price} | Add to cart",
                        color: Colors.white,
                      ),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
