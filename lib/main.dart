import 'package:flutter/material.dart';

import 'Interfaces/HomePage.dart';

// Code Reference: https://youtu.be/KfhBsahIk7w

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Todo List',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.light,
      ),
      home: const HomePage(title: 'todo list'),
    );
  }
}
