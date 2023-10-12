import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List _shopItems = [
    ["Cabbage", "30", "assets/images/img_1.png", Colors.green, 0],
    ["Broccoli", "70", "assets/images/img_2.png", Colors.blueAccent, 0],
    ["Carrot", "50", 'assets/images/img_3.png', Colors.amber, 0],
    ["Pakcoy", "40", 'assets/images/img_4.png', Colors.amberAccent, 0],
  ];
  var count = 0;

  List _cartItems = [];
  // Set<List<String>> setOfArrays = Set<List<String>>.from(_cartItems);
  get cartItems => _cartItems;

  get shopItems => _shopItems;

  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    count += 1;
    notifyListeners();
  }

  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    count -= 1;
    // _cartItems[index][4] -= 1;
    notifyListeners();
  }

  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += double.parse(_cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }

  // void quantityCart(int index) {
  //   _cartItems[index][4] += 1;
  // }
}
