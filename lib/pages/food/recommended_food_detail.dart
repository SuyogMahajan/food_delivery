import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';

import '../../widgets/big_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height20),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20)),
                    color: Colors.white),
                child: Center(
                    child: BigText(
                        size: Dimensions.font26, text: "Silver App Bar")),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/image/food0.png",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: ExpandableTextWidget(
                  text:
                      "Biryani is a rice dish cooked in a layered manner with meat and vegetables. It originated in Persia, but it was made popular by the Mughals, who ruled India for several centuries (1526 to 1857). The popularity of biryani spread throughout India after that time.Biryani is a rice dish cooked in a layered manner with meat and vegetables. It originated in Persia, but it was made popular by the Mughals, who ruled India for several centuries (1526 to 1857). The popularity of biryani spread throughout India after that time.Biryani is a rice dish cooked in a layered manner with meat and vegetables. It originated in Persia, but it was made popular by the Mughals, who ruled India for several centuries (1526 to 1857). The popularity of biryani spread throughout India after that time.Biryani is a rice dish cooked in a layered manner with meat and vegetables. It originated in Persia, but it was made popular by the Mughals, who ruled India for several centuries (1526 to 1857). The popularity of biryani spread throughout India after that time.Biryani is a rice dish cooked in a layered manner with meat and vegetables. It originated in Persia, but it was made popular by the Mughals, who ruled India for several centuries (1526 to 1857). The popularity of biryani spread throughout India after that time.Biryani is a rice dish cooked in a layered manner with meat and vegetables. It originated in Persia, but it was made popular by the Mughals, who ruled India for several centuries (1526 to 1857). The popularity of biryani spread throughout India after that time.Biryani is a rice dish cooked in a layered manner with meat and vegetables. It originated in Persia, but it was made popular by the Mughals, who ruled India for several centuries (1526 to 1857). The popularity of biryani spread throughout India after that time.Biryani is a rice dish cooked in a layered manner with meat and vegetables. It originated in Persia, but it was made popular by the Mughals, who ruled India for several centuries (1526 to 1857). The popularity of biryani spread throughout India after that time.Biryani is a rice dish cooked in a layered manner with meat and vegetables. It originated in Persia, but it was made popular by the Mughals, who ruled India for several centuries (1526 to 1857). The popularity of biryani spread throughout India after that time.Biryani is a rice dish cooked in a layered manner with meat and vegetables. It originated in Persia, but it was made popular by the Mughals, who ruled India for several centuries (1526 to 1857). The popularity of biryani spread throughout India after that time.Biryani is a rice dish cooked in a layered manner with meat and vegetables. It originated in Persia, but it was made popular by the Mughals, who ruled India for several centuries (1526 to 1857). The popularity of biryani spread throughout India after that time.Biryani is a rice dish cooked in a layered manner with meat and vegetables. It originated in Persia, but it was made popular by the Mughals, who ruled India for several centuries (1526 to 1857). The popularity of biryani spread throughout India after that time.Biryani is a rice dish cooked in a layered manner with meat and vegetables. It originated in Persia, but it was made popular by the Mughals, who ruled India for several centuries (1526 to 1857). The popularity of biryani spread throughout India after that time.Biryani is a rice dish cooked in a layered manner with meat and vegetables. It originated in Persia, but it was made popular by the Mughals, who ruled India for several centuries (1526 to 1857). The popularity of biryani spread throughout India after that time.Biryani is a rice dish cooked in a layered manner with meat and vegetables. It originated in Persia, but it was made popular by the Mughals, who ruled India for several centuries (1526 to 1857). The popularity of biryani spread throughout India after that time.",
                ),
              )
            ],
          ))
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20 * 2.5,
                right: Dimensions.width20 * 2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  iconSize: Dimensions.iconSize24,
                  iconColor: Colors.white,
                  icon: Icons.remove,
                  backgroundColor: AppColors.mainColor,
                ),
                BigText(
                  text: "\$" + "12.88" + " X " + "0",
                  color: AppColors.mainBlackColor,
                  size: Dimensions.font26,
                ),
                AppIcon(
                  iconSize: Dimensions.iconSize24,
                  iconColor: Colors.white,
                  icon: Icons.add,
                  backgroundColor: AppColors.mainColor,
                )
              ],
            ),
          ),
          Container(
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
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      bottom: Dimensions.height15,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: BigText(
                    text: "\$10 | Add to cart",
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
