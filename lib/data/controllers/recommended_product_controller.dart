import 'package:food_delivery/data/repository/recommended_product_repo.dart';
import 'package:get/get.dart';

import '../../models/products_model.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  RecommendedProductController({required this.recommendedProductRepo});

  // this is a private element
  List<dynamic> _recommendedProductList =[];

  // getter for list
  List<dynamic> get recommendedProductList => _recommendedProductList;

  // getting dara from repository
  Future<void> getrRecommendedProductList() async {
    //await will wait till we get a response
    Response response = await recommendedProductRepo.getRecommendedProductList();

    if(response.statusCode != 1){
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      print(_recommendedProductList);
      // this update will update our ui
      _isLoaded = true;
      update();
    }else{

    }
  }

}