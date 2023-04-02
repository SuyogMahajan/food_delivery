import 'dart:convert';

import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];

  void  addToCartList(List<CartModel> cartList) {

    cart =[];

    cartList.forEach((element) {
      return
      cart.add(jsonEncode(element.toJson()));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    // print(sharedPreferences.getStringList(AppConstants.CART_LIST));

     // to get data back
    // getCartList();
  }

  List<CartModel> getCartList() {

    List<String> carts = [];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
     carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }

    List<CartModel> cartList = [];

    for (var value in carts) {
      print(value);
      cartList.add(CartModel.fromJson(jsonDecode(value)));
    }

    return cartList;
  }

}
