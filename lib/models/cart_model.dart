import 'package:flutter/material.dart';
import 'package:grocery_app/services/quantity.dart';
import 'package:grocery_app/snackbar.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class CartModel extends ChangeNotifier {
  final List _shopItems = [
    ["Cabbage", "30", "assets/images/img_1.png", Colors.green, 0],
    ["Broccoli", "70", "assets/images/img_2.png", Colors.blueAccent, 0],
    ["Carrot", "50", 'assets/images/img_3.png', Colors.amber, 0],
    ["Pakcoy", "40", 'assets/images/img_4.png', Colors.amberAccent, 0],
  ];
  var count = 0;
  bool isPresent = false;
  List _cartItems = [];

  get cartItems => _cartItems;

  get shopItems => _shopItems;
  var dataId;

  void addItemToCart(int index) {
    count += 1;
    // Quantity.postCount(count, id);

    for (int i = 0; i < _cartItems.length; i++) {
      if (_cartItems[i][0] == _shopItems[index][0]) {
        _cartItems[i][4] +=
            1; // Increment the quantity if the same item is found
        isPresent = true;
        break;
      }
    }

    if (!isPresent) {
      // _cartItems.add(List.from(_shopItems[index])..add(1));
      _cartItems.add(_shopItems[index]);
      _cartItems[_cartItems.length - 1][4] += 1; // Add the item to the cart
    }
    isPresent = false;

    notifyListeners();
  }

  void removeItemFromCart(int index) {
    for (int i = 0; i < _cartItems.length; i++) {
      if (_cartItems[i][0] == _shopItems[index][0]) {
        count -= (_cartItems[i][4] as int);
        _cartItems[i][4] = 0;
        _cartItems.removeAt(i);
      }
    }
    notifyListeners();
  }

  void updateCount(String id, int updatedCount, updatedShopItems) {
    dataId = id;
    if (updatedCount > 0) {
      count = updatedCount;
      for (int i = 0; i < updatedShopItems.length; i++) {
        for (int j = 0; j < updatedShopItems.length; j++) {
          if (_shopItems[i][0] == updatedShopItems[j][0]) {
            _shopItems[i][4] = (updatedShopItems[j][1]);
            _cartItems.add(_shopItems[i]);
          }
        }
      }
    }
  }

  void deleteItemFromCart(int index, context) {
    if (count > 0) {
      for (int i = 0; i < _cartItems.length; i++) {
        if (_cartItems[i][0] == _shopItems[index][0]) {
          _cartItems[i][4] -= 1;
          count -= 1;
          if (_cartItems[i][4] == 0) {
            _cartItems.removeAt(i);
          }
          break;
        }
        showSnackBar(context, 'Please first select this item');
      }
    } else {
      showSnackBar(context, 'Please first select any item');
    }
    notifyListeners();
  }

  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += (double.parse(_cartItems[i][1]) *
          double.parse(_cartItems[i][4].toString()));
    }
    return totalPrice.toStringAsFixed(2);
  }
}
