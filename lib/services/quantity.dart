import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:http/http.dart' as http;

class Quantity {
  static const baseUrl = "http://localhost:3001/api/";

  static postCount(String count, String id, List<dynamic> arr) async {
    try {
      debugPrint('arrrrr${arr}');
      // List<dynamic>newList = jsonEncode(arr);
      final Map<String, dynamic> requestBody = {
        'count': count,
        'shopItems': arr,
      };
      debugPrint('Able to update count');
      final res = await http.patch(
        Uri.parse('${baseUrl}count${id}'),
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json', // Set the content type
        },
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        debugPrint('Success');
        debugPrint('patch${data}');
      } else {
        debugPrint('Not able to update count');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

// debugPrint('ccount${count}iiiiiiiid${id}');
//       debugPrint('arrrrr${arr}');

  // static postCartItems(String id, List arr) async {
  //   debugPrint('CartVAlues###${arr}');
  //   try {
  //     final Map requestBody = {
  //       'shopItems': arr // Assuming 'count' is the key the API expects
  //     };
  //     debugPrint('CartVAlues###${requestBody}');
  //     final res = await http.patch(Uri.parse('${baseUrl}count${id}'),
  //         body: jsonEncode(requestBody));
  //     if (res.statusCode == 200) {
  //       var data = jsonDecode(res.body);
  //       debugPrint('Success');
  //       debugPrint('patch${data}');
  //     } else {
  //       debugPrint('Not able to update items');
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
}
