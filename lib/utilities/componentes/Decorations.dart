import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practilab/res/values/Colors.dart';


class Decorations
{

  InputDecoration decorationtext({String hintText,final Color colorHint=ColorsApp.black,Color colorBorder=ColorsApp.blue,Color colorBorderFocused=ColorsApp.blue})
  {
    return InputDecoration(

      hintText: hintText,
      hintStyle: styleTextView(color: colorHint,textSize: 16),
      fillColor: ColorsApp.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: colorBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: colorBorderFocused),
      ),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsApp.white,),
            borderRadius: BorderRadius.circular(30.0)
        ),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: ColorsApp.white),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 20)
    );
  }
  TextStyle styleTextView({Color color,double textSize=18,FontWeight fontWeight=FontWeight.normal,String fontFamily})
  {
    return TextStyle(
        color: color,
        fontSize: textSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily
    );
  }
}