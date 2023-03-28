import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/controllers/popular_product_controller.dart';
import '../../data/controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResources() async {

    await Get.find<PopularProductController>().getPopularProductList();
   await Get.find<RecommendedProductController>().getrRecommendedProductList();

  }

  @override
  void initState() {
    super.initState();
    _loadResources();
    
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);


    Timer(
     const Duration(milliseconds: 2500) ,
    ()=>Get.offNamed(RouteHelper.getInitial())

    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
                child: Image.asset(
              "assets/image/logo part 1.png",
              width: 250,
            )),
          ),
          ScaleTransition(
            scale: animation,
            child: Center(
                child: Image.asset(
                  "assets/image/logo part 2.png",
                  width: 250,
                )),
          ),
        ],
      ),
    );
  }

}
