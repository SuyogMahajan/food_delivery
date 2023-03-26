import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

import '../../models/products_model.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  int _quantity = 0;

  int get quantity => _quantity;
  int _inCartItems = 0;

  int get inCartItems => _inCartItems + _quantity;
  late CartController _cart;

  PopularProductController({required this.popularProductRepo});

  // this is a private element
  List<dynamic> _popularProductList = [];

  // getter for list
  List<dynamic> get popularProductList => _popularProductList;

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }

  // getting dara from repository
  Future<void> getPopularProductList() async {
    //await will wait till we get a response
    Response response = await popularProductRepo.getPopularProductList();

    if (response.statusCode != 1) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print(_popularProductList);
      // this update will update our ui
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
         } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    print("number of items ${_quantity.toString()}");
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Not possible", "you can't reduce more !",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return -1*_inCartItems;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar("Ohh Sorry !", "you can't add more !",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cartController) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cartController;
    var exist = false;

    exist = _cart.existInCart(product);
    // if exists
    // get from storage_inCartItems
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
      print("quantity in cart : " + _inCartItems.toString());
    }

  }

  void addItem(ProductModel productModel) {
    if (_inCartItems + _quantity >= 0) {
      _cart.addItem(productModel, _quantity);
      _quantity = 0;
      _inCartItems = _cart.getQuantity(productModel);
      _cart.items.forEach((key, value) {
        print("id ${value.id!} quantity ${value.quantity!}");
      });
    } else {

      Get.snackbar("Not possible !", "You should at least add one item.",
          backgroundColor: AppColors.iconColor1);
    }
    update();
  }
}
