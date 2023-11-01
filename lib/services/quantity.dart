import 'dart:convert'; // Import the 'dart:convert' library for working with JSON data
import 'package:flutter/material.dart'; // Import the Flutter material package for UI components
import 'package:grocery_app/models/product_model.dart'; // Import a custom model
import 'package:http/http.dart'
    as http; // Import the 'http' package for making HTTP requests

class Quantity {
  static const baseUrl =
      "http://localhost:3001/api/"; // Define the base URL for the API

  // Function to send a patch request to update quantity
  static postCount(String count, String id, List<dynamic> arr) async {
    try {
      final Map<String, dynamic> requestBody = {
        'count': count, // Quantity to update
        'shopItems': arr, // List of items to update
      };
      debugPrint(
          'Able to update count'); // Log a message indicating the attempt to update
      final res = await http.patch(
        Uri.parse(
            '${baseUrl}count${id}'), // Define the API endpoint URL with ID
        body: jsonEncode(requestBody), // Encode the request body as JSON
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
        },
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body); // Decode the response JSON data
        debugPrint('Success'); // Log a success message
      } else {
        debugPrint('Not able to update count'); // Log an error message
      }
    } catch (e) {
      debugPrint(e.toString()); // Log any exceptions that occur
    }
  }
}
