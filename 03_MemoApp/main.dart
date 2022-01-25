import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange, primaryColor: Colors.white, //primarySwatch 버튼 색, primaryColor 배경 색
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

