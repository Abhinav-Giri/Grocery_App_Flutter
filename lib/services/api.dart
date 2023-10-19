import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "http://localhost:3001/api/";

  // static get http => null;

  static apiCall(data) async {
    try {
      final res = await http.post(Uri.parse('${baseUrl}signup'), body: data);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        debugPrint(data);
      } else {
        debugPrint('Not able to post');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
