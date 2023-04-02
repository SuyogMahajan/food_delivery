import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/data/controllers/cart_controller.dart';
import 'package:food_delivery/data/controllers/popular_product_controller.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/controllers/recommended_product_controller.dart';
import '../data/repository/popular_product_repo.dart';
import '../data/repository/recommended_product_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async {

  final sharedPreferences = await SharedPreferences.getInstance();


  Get.lazyPut(() => sharedPreferences);
// api clients
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

// repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:sharedPreferences));

//controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));

}
