
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';


Widget ToastCustomized(String content)
{
  return Container
       (
       padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(25.0),
         color: ColorsApp.blue,
       ),
       child: Row(
         mainAxisSize: MainAxisSize.min,
         children: [
           Icon(Icons.check, color: ColorsApp.white,),
           TextViewBuilder(content,colorfont: ColorsApp.white,fontWeight: FontWeight.w400,textSize: 15),
         ],
       ),
     );

}

