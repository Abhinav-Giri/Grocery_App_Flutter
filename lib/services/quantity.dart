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

  static getDirectLogin(String email) async {
    // List credentials = [];, 'shopItem': items
    try {
      final res = await http.get(Uri.parse('${baseUrl}get_login${email}'));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        debugPrint("Pre success!");
        var id = (data["data"]["_id"].toString());
        debugPrint('id######:${id}');
        // List<List> items
        List<dynamic> items = (data["data"]["shopItems"])!;
        String updatedCount = (data["data"]["count"]);
        int updCount = int.parse(updatedCount);

        debugPrint('items???????:${items}');
        debugPrint("NewUpdatedCount${updCount}");

        var responseData = ({
          'ids': id,
          'count': updCount,
          'shopItems': items,
        });
        return (responseData);
      } else if (res.statusCode == 404) {
        debugPrint('Failed');
      } else if (res.statusCode == 500) {
        debugPrint(' Server Failed');
      } else {
        debugPrint('Not able to get');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
