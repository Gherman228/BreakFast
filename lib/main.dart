import 'package:flutter/material.dart';
import 'package:money_management/Pages/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'WinkySans-Black'),
      home: git remote add origin https://github.com/username/nume-repository.git
        HomePage()
    );
  }
}

