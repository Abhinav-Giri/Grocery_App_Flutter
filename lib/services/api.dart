import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "http://localhost:3001/api/";

  // static get http => null;

  static signup(Map data) async {
    try {
      final res = await http.post(Uri.parse('${baseUrl}signup'), body: (data));
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

  static getcredentials(String checkEmail, bool checkLogin) async {
    // List credentials = [];
    try {
      final res =
          await http.get(Uri.parse('${baseUrl}get_signup${checkEmail}'));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        debugPrint("Pre success!");
        checkLogin = true;

        // debugPrint('stringID%%%%%%%${data["data"]["_id"].toString()}');
        debugPrint('BOOOOOOOOOOL${checkLogin}');
        var id = (data["data"]["_id"].toString());
        debugPrint('id######:${id}');
        var responseData = ({'checkLogins': checkLogin, 'ids': id});
        return (responseData);
        // data[]

        // await data['data'].forEach((value) => {(value.email == checkEmail)});

        // debugPrint(data.data);
      } else if (res.statusCode == 404) {
        debugPrint('Failed');
        return checkLogin = false;
      } else if (res.statusCode == 500) {
        debugPrint(' Server Failed');
        return checkLogin = false;
      } else {
        debugPrint('Not able to get');
        return checkLogin = false;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
