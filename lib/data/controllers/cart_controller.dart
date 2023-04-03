import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:get/get.dart';

import '../../models/cart_model.dart';
import '../../models/products_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  // for storage and shared preferences
  List<CartModel> storageItems = [];

  // getting total products in cart
  int get totalItems {
    var totalQuantity = 0;

    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });

    // print("totalQuantity : $totalQuantity");

    return totalQuantity;
  }
  int get totalAmount {
    var totalAmount = 0;

    _items.forEach((key, value) {
      totalAmount += value.price! * value.quantity!;
    });

    return totalAmount;
  }
  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }
  set setItems(Map<int,CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  CartController({required this.cartRepo});

  // does product added previus
  bool existInCart(ProductModel productModel) {
    return _items.containsKey(productModel.id!);
  }

  // adding item to store in memory and its quantity to map
  void addItem(ProductModel product, int quantity) {
    var totalQuantity = quantity;
    // print("length of the item is "+_items.length.toString());

    _items.update(product.id!, (value) {
      totalQuantity += value.quantity!;

      return CartModel(
        id: value.id,
        name: value.name,
        price: value.price,
        img: value.img,
        quantity: value.quantity! + quantity,
        isExist: true,
        time: DateTime.now().toString(),
        product: value.product,
      );
    }, ifAbsent: () {
      return CartModel(
        id: product.id,
        name: product.name,
        price: product.price,
        img: product.img,
        quantity: quantity,
        isExist: true,
        time: DateTime.now().toString(),
        product: product,
      );
    });

    if (totalQuantity <= 0) _items.remove(product.id!);

    cartRepo.addToCartList(getItems);
    update();
  }

  // get previous quantity
  int getQuantity(ProductModel product) {
    int quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;

    for (int i = 0; i<storageItems.length;i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }

  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }



  List<CartModel> getCartHistoryList() {
    return cartRepo.getHistoryList();
  }


  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }
}
