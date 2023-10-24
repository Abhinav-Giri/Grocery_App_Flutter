import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:http/http.dart' as http;

class Quantity {
  static const baseUrl = "http://localhost:3001/api/";

  static postCount(count, id) async {
    try {
      final Map requestBody = {
        'count':
            (count as String), // Assuming 'count' is the key the API expects
      };
      final res = await http.patch(Uri.parse('${baseUrl}count${id}'),
          body: (requestBody));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        debugPrint('Success');
      } else {
        debugPrint('Not able to post');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // static itemQuantity(Map data) async {
  //   try {
  //     final res = await http.post(Uri.parse('${baseUrl}items'), body: (data));
  //     if (res.statusCode == 200) {
  //       var data = jsonDecode(res.body);
  //       debugPrint('Success');
  //     } else {
  //       debugPrint('Not able to post');
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
}
