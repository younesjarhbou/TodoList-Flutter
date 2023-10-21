import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todolist/config.dart';

class functionLibrary {
  static Future<void> makePostRequest(Map<String, dynamic> body) async {
    final url = Uri.parse(config.api_url + 'todos');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('jarhbou Post request successful!');
      print(response.body);
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  static Future<void> sendPutRequest(String id) async {
    // Define the endpoint URL
    final url = Uri.parse(config.api_url + 'todos/' + id);

    // Create a JSON body
    final body = jsonEncode({"completed": true});

    try {
      // Send the PUT request
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        // Put request was successful
        print('jarhbou PUT request successful');
      } else {
        // Put request failed
        print(
            'jarhbou PUT request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      // An error occurred while sending the PUT request
      print('Error: $e');
    }
  }
}
