import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

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
   //   _popularProductList.addAll(we need model here);
      // this update will update our ui
      update();
    }else{

    }
  }

}