import 'dart:convert';

import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void  addToCartList(List<CartModel> cartList) {

    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    // sharedPreferences.remove(AppConstants.CART_LIST);

    var time = DateTime.now().toString();
    cart =[];

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element.toJson()));
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

  List<CartModel> getHistoryList() {
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    List<CartModel> cartHistoryList = [];
    cartHistory.forEach((element) {
      cartHistoryList.add(CartModel.fromJson(jsonDecode(element)));
    });

    // cartHistoryList.forEach((element) {
    //   print("id ${element.id}  time ${element.time}");
    // });

    return cartHistoryList;
  }

  void addToCartHistoryList() {

    for(int i = 0;i < cart.length;i++) {
      print(cart[i]);
      cartHistory.add(cart[i]);
    }
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
    removeCart();

    print("length is  : " + getHistoryList().length.toString());

  }

  void removeCart() {
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

}
