import 'dart:convert'; // Import the 'dart:convert' library for working with JSON data
import 'package:flutter/material.dart'; // Import the Flutter material package for UI components
import 'package:grocery_app/models/product_model.dart'; // Import a custom model
import 'package:http/http.dart'
    as http; // Import the 'http' package for making HTTP requests

class Api {
  static const baseUrl =
      "http://localhost:3001/api/"; // Define the base URL for the API

  // Function to send a signup request to the API
  static signup(Map data) async {
    try {
      final res = await http.post(Uri.parse('${baseUrl}signup'), body: (data));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body); // Decode the response JSON data
        debugPrint('Success'); // Log a success message
      } else {
        debugPrint('Not able to post'); // Log an error message
      }
    } catch (e) {
      debugPrint(e.toString()); // Log any exceptions that occur
    }
  }

  // Function to get user credentials from the API
  static getcredentials(String checkEmail, bool checkLogin) async {
    try {
      final res =
          await http.get(Uri.parse('${baseUrl}get_signup${checkEmail}'));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body); // Decode the response JSON data
        checkLogin = true; // Set 'checkLogin' to true to indicate success
        var id = (data["data"]["_id"].toString());
        List<dynamic> items = (data["data"]["shopItems"])!;
        String updatedCount = (data["data"]["count"]);
        int updCount = int.parse(updatedCount);

        // Create a response data object with the retrieved data
        var responseData = ({
          'checkLogins': checkLogin,
          'ids': id,
          'count': updCount,
          'shopItems': items
        });

        return (responseData); // Return the response data
      } else if (res.statusCode == 404) {
        debugPrint('Failed'); // Log a failure message
        return checkLogin =
            false; // Set 'checkLogin' to false to indicate failure
      } else if (res.statusCode == 500) {
        debugPrint(' Server Failed'); // Log a server failure message
        return checkLogin =
            false; // Set 'checkLogin' to false to indicate server failure
      } else {
        debugPrint('Not able to get'); // Log an error message
        return checkLogin = false; // Set 'checkLogin' to false for other errors
      }
    } catch (e) {
      debugPrint(e.toString()); // Log any exceptions that occur
    }
  }
}
