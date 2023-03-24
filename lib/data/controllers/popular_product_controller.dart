import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

import '../../models/products_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  PopularProductController({required this.popularProductRepo});

  // this is a private element
  List<dynamic> _popularProductList =[];

  // getter for list
  List<dynamic> get popularProductList => _popularProductList;

  // getting dara from repository
  Future<void> getPopularProductList() async {
    //await will wait till we get a response
    Response response = await popularProductRepo.getPopularProductList();

    if(response.statusCode != 1){
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print(_popularProductList);
      // this update will update our ui
      _isLoaded = true;
      update();
    }else{

    }
  }

}