import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todolist/config.dart';
import 'package:todolist/screen/home.dart';

class functionLibrary {
  static Future<void> makePostRequest(Map<String, dynamic> body) async {
    final url = Uri.parse(config.api_url + 'todos');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${config.token}', // Add the Authorization header with the JWT token
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      print('jarhbou Post request successful!');
      print("jarhbou response.body " + response.body);
      config.insertedtodo = json.decode(response.body);
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
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${config.token}', // Add the Authorization header with the JWT token
        },
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

  static Future<void> deleteTodoById(String id) async {
    try {
      final url = Uri.parse(config.api_url + 'todos/$id');
      final response = await http.delete(
        url,
        headers: {
          'Authorization':
              'Bearer ${config.token}', // Add the Authorization header with the JWT token
        },
      );

      if (response.statusCode == 200) {
        final deletedTodo = json.decode(response.body);
        print(deletedTodo);
      } else if (response.statusCode == 404) {
        print({'error': 'Todo not found'});
      } else {
        print({'error': 'Failed to delete todo.'});
      }
    } catch (ex) {
      print(ex);
    }
  }

  static Future<void> fetchData(BuildContext context, bool goNext) async {
    try {
      List<Map<String, dynamic>> todoList = [];
      final response = await http.get(
        Uri.parse(config.api_url + 'todos'),
        headers: {
          'Authorization': 'Bearer ${config.token}', // Add the Authorization header with the JWT token
        },
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
  
        todoList = List<Map<String, dynamic>>.from(data);
  
        if (goNext) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home(todoList)),
          );
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  
}
