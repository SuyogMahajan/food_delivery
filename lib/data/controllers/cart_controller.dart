import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:get/get.dart';

import '../../models/cart_model.dart';
import '../../models/products_model.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  Map<int, CartModel> _items={};
  Map<int, CartModel> get items => _items;

  CartController({required this.cartRepo});

  bool existInCart(ProductModel productModel) {
    return _items.containsKey(productModel.id!);
  }

  void addItem(ProductModel product,int quantity) {

      // print("length of the item is "+_items.length.toString());

         _items.update(product.id!, (value) {
           return CartModel(
           id: value.id,
           name: value.name,
           price: value.price,
           img: value.img,
           quantity: value.quantity! + quantity,
           isExist: true,
           time: DateTime.now().toString(),
         );
         },ifAbsent: (){
           return CartModel(
             id: product.id,
             name: product.name,
             price: product.price,
             img: product.img,
             quantity: quantity,
             isExist: true,
             time: DateTime.now().toString(),
           );
         });

      _items.forEach((key, value) =>{
        print("id $key quantity ${value.quantity!}")
      });

  }

  int getQuantity(ProductModel product) {
     var quantity = 0;
    if(_items.containsKey(product.id!)){
      _items.forEach((key, value) {
        if(key == product.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }
}