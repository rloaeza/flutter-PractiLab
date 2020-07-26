import 'package:flutter/material.dart';
import 'package:practilab/Wrapper.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/DrawableValues.dart';
import 'package:practilab/utilities/helpers/ImageHelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: ColorsApp.yelow,
      primaryColorLight: ColorsApp.yelow),
      debugShowCheckedModeBanner: false,
      home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
              fit: BoxFit.fill,
              image: ImageHelper.getAsset(DrawableValues.BACKGROUND_IMAGE)
              )
          ),
          child:Wrapper()
      )
    );

  }
}


