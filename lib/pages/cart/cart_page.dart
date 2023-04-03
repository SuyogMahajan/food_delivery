import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/data/controllers/cart_controller.dart';
import 'package:food_delivery/data/controllers/popular_product_controller.dart';
import 'package:food_delivery/main.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../data/controllers/recommended_product_controller.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../home/main_food_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          // back home cart icons
          Positioned(
              top: Dimensions.height20 * 3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                    iconColor: Colors.white,
                  ),
                  SizedBox(
                    width: Dimensions.width20 * 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                      iconColor: Colors.white,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                    iconColor: Colors.white,
                  ),
                ],
              )),

          //list view
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.length > 0 ?  Positioned(
              top: Dimensions.height20 * 5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                // color: Colors.blueGrey[100],
                margin: EdgeInsets.only(top: Dimensions.height15),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(
                    builder: (cartController) {
                      var _cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          //for each item in list
                          itemBuilder: (_, index) {
                            return Container(
                              height: Dimensions.height20 * 5,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  // image
                                  GestureDetector(
                                    onTap: () {
                                      var popularProduct =
                                      Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(_cartList[index].product);

                                      if (popularProduct >= 0) {
                                        Get.toNamed(RouteHelper.getPopularFood(
                                            popularProduct,"cartpage"));
                                      } else {
                                        var recommendedProduct = Get.find<
                                            RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(_cartList[index].product);
                                        if(recommendedProduct < 0) {
                                          Get.snackbar("History Product","Product review is not available for history !!",backgroundColor: AppColors.mainColor,colorText: Colors.white);

                                        }else{

                                          Get.toNamed(
                                              RouteHelper.getRecommendedFood(
                                                  recommendedProduct,"cartpage"));
                                        }}
                                    },
                                    child: Container(
                                      width: Dimensions.height20 * 5,
                                      height: Dimensions.height20 * 5,
                                      margin: EdgeInsets.only(
                                          bottom: Dimensions.height10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                          color: Colors.white,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL +
                                                      AppConstants.UPLOAD_URL +
                                                      _cartList[index].img!))),
                                    ),
                                  ),

                                  SizedBox(
                                    width: Dimensions.width10,
                                  ),

                                  // second side text colum
                                  Expanded(
                                      child: Container(
                                        height: Dimensions.height20 * 5,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // title
                                            BigText(
                                              text: _cartList[index].name!,
                                              color: Colors.black54,
                                            ),
                                            SmallText(
                                              text: "sweet",
                                            ),

                                            // price adding removing items
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                BigText(
                                                  text:
                                                  "\$ ${_cartList[index].price!}",
                                                  color: Colors.red,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: Dimensions.height10,
                                                      bottom: Dimensions.height10,
                                                      left: Dimensions.width10,
                                                      right: Dimensions.width10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius20),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          cartController.addItem(
                                                              _cartList[index]
                                                                  .product!,
                                                              -1);
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: AppColors.signColor,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width:
                                                          Dimensions.width10 / 2),
                                                      BigText(
                                                          text: _cartList[index]
                                                              .quantity
                                                              .toString()),
                                                      SizedBox(
                                                          width:
                                                          Dimensions.width10 / 2),
                                                      GestureDetector(
                                                        onTap: () {
                                                          cartController.addItem(
                                                              _cartList[index]
                                                                  .product!,
                                                              1);
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: AppColors.signColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            );
                          });
                    },
                  ),
                ),
              ),
            ) : NoDataPage(text: "Cart is empty !!");
          })
        ],
      ),
      bottomNavigationBar:   GetBuilder<CartController>(
        builder: (cartController) {
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
            child: cartController.getItems.length > 0 ? Row(
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

                      SizedBox(width: Dimensions.width10 / 2),
                      BigText(text: "\$ ${cartController.totalAmount}"),
                      SizedBox(width: Dimensions.width10 / 2),

                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cartController.addToHistory();
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height15,
                        bottom: Dimensions.height15,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    child: BigText(
                      text: "Check out",
                      color: Colors.white,
                    ),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor),
                  ),
                )
              ],
            ) : Container(),
          );
        },
      ),
    );
  }
}
