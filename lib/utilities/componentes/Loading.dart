import 'package:flutter/material.dart';
import 'package:practilab/res/values/Animation.dart';
import 'package:practilab/res/values/Colors.dart';

Widget Loading()
{
  FadeAnimation(1,
      Center(
          child: CircularProgressIndicator(
            backgroundColor: ColorsApp.yelow,
            valueColor: new AlwaysStoppedAnimation<Color>(
                Colors.transparent),))
  );
}