import 'package:flutter/material.dart';
import 'package:practilab/values/Colors.dart';
import 'package:practilab/views/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: ColorsApp.yelow),
      debugShowCheckedModeBanner: false,
      home: Login(title: 'Flutter Demo Home Page'),

    );
  }
}


