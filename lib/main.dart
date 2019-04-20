import 'package:flutter/material.dart';
import 'package:jokes/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jokes App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: HomePage(),
    );
  }
}
