

import 'package:flutter/material.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';

class ButtonPressedRaised extends StatelessWidget
{
  Color color;
  int elevation;
  String title;
  VoidCallback onPressed;
  ButtonPressedRaised({Key key, @required String title,VoidCallback onPressed,int elevation=10,Color color = ColorsApp.blue}):super(key: key){
    this.title=title;
    this.onPressed=onPressed;
    this.color =color;
    this.elevation =elevation;
  }
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: onPressed,
      elevation: this.elevation.toDouble(),
      color: this.color,
      child: TextViewBuilder(title,colorfont: ColorsApp.white,textSize: 20.0,fontWeight: FontWeight.w400),
    );
  }
}