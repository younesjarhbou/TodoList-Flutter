import 'package:flutter/material.dart';
import 'package:todolist/config.dart';
import 'package:todolist/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todolist/screen/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<Map<String, dynamic>> todoList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse(config.api_url+'todos'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          todoList = List<Map<String, dynamic>>.from(data);
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(todoList)),
        );
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}