import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:todolist/screen/splash.dart';

void main() {
  // Initialize the Flutter app for web
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}
