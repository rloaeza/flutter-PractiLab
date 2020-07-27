

import 'package:flutter/material.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/utilities/componentes/Decorations.dart';

Widget TextViewBuilder(@required String text,{double textSize=18, Color colorfont=ColorsApp.black,FontWeight fontWeight=FontWeight.normal,String fontFamily=""})
{
  return Text(text,style: Decorations().styleTextView(textSize: textSize,color: colorfont,fontWeight: fontWeight,fontFamily: fontFamily,),);
}
Widget TextViewBuilderElipsis(@required String text,{double textSize=18, Color colorfont=ColorsApp.black,FontWeight fontWeight=FontWeight.normal,String fontFamily=""})
{
  return Text(text,overflow:TextOverflow.ellipsis,style: Decorations().styleTextView(textSize: textSize,color: colorfont,fontWeight: fontWeight,fontFamily: fontFamily,),);
}


