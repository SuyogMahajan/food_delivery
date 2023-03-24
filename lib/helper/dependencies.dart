import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/data/controllers/popular_product_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../data/repository/popular_product_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async {

// api clients
Get.lazyPut(()=> ApiClient(appBaseUrl: AppConstants.BASE_URL));

// repos
Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

//controllers
Get.lazyPut(() => PopularProductController( popularProductRepo: Get.find()));

}