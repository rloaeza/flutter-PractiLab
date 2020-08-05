import 'package:flutter/material.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/utilities/componentes/Decorations.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';




class ButtonSheet extends StatefulWidget {
  @override
  _ButtonSheetState createState() => new _ButtonSheetState();
 }
class _ButtonSheetState extends State<ButtonSheet> {
  @override
  Widget build(BuildContext context) {
     return ListView(
       children: <Widget>
       [
         TextViewBuilder(
             Strings.ACTUALIZADATOS, colorfont: ColorsApp.blue,),
         SizedBox(height: 20.0,),
         SizedBox(
             height: 70,
             width: MediaQuery.of(context).size.width/2+100,
             child: Stack(
                 children:<Widget>[
                   Material(
                       elevation: 5,
                       borderRadius: BorderRadius.circular(30),
                       child: Padding(padding: EdgeInsets.symmetric(vertical: 23,horizontal: 300),)
                   ),
                   TextFormField(
                     //key: _keytextpass,

                     obscureText: true,
                     decoration: Decorations().decorationtext(hintText: Strings.NAME,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                     validator: (String val)
                     {
                       //val=password;
                       //print(val);
                       return val.isEmpty?"Error, campo vacío":null;
                     },
                     onChanged: (String pass)
                     {
                       //password=pass;
                       // _keytextpass.currentState.validate();
                     },
                   ),
                 ]
             )
         ),
         SizedBox(
             height: 70,
             width: MediaQuery.of(context).size.width/2+100,
             child: Stack(
                 children:<Widget>[
                   Material(
                       elevation: 5,
                       borderRadius: BorderRadius.circular(30),
                       child: Padding(padding: EdgeInsets.symmetric(vertical: 23,horizontal: 300),)
                   ),
                   TextFormField(
                     //key: _keytextpass,

                     obscureText: true,
                     decoration: Decorations().decorationtext(hintText: Strings.LASTNAME,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                     validator: (String val)
                     {
                       //val=password;
                       //print(val);
                       return val.isEmpty?"Error, campo vacío":null;
                     },
                     onChanged: (String pass)
                     {
                       //password=pass;
                       // _keytextpass.currentState.validate();
                     },
                   ),
                 ]
             )
         ),
         SizedBox(
             height: 70,
             width: MediaQuery.of(context).size.width/2+100,
             child: Stack(
                 children:<Widget>[
                   Material(
                       elevation: 5,
                       borderRadius: BorderRadius.circular(30),
                       child: Padding(padding: EdgeInsets.symmetric(vertical: 23,horizontal: 300),)
                   ),
                   TextFormField(
                     //key: _keytextpass,

                     obscureText: true,
                     decoration: Decorations().decorationtext(hintText: Strings.CTRL_NUMBER,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                     validator: (String val)
                     {
                       //val=password;
                       //print(val);
                       return val.isEmpty?"Error, campo vacío":null;
                     },
                     onChanged: (String pass)
                     {
                       //password=pass;
                       // _keytextpass.currentState.validate();
                     },
                   ),
                 ]
             )
         ),
         SizedBox(
             height: 70,
             width: MediaQuery.of(context).size.width/2+100,
             child: Stack(
                 children:<Widget>[
                   Material(
                       elevation: 5,
                       borderRadius: BorderRadius.circular(30),
                       child: Padding(padding: EdgeInsets.symmetric(vertical: 23,horizontal: 300),)
                   ),
                   TextFormField(
                     //key: _keytextpass,

                     obscureText: true,
                     decoration: Decorations().decorationtext(hintText: Strings.PHONE,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                     validator: (String val)
                     {
                       //val=password;
                       //print(val);
                       return val.isEmpty?"Error, campo vacío":null;
                     },
                     onChanged: (String pass)
                     {
                       //password=pass;
                      // _keytextpass.currentState.validate();
                     },
                   ),
                 ]
             )
         ),
         SizedBox(height: 20.0,),
         RaisedButton(
           child: TextViewBuilder(Strings.SIGNUP,colorfont: ColorsApp.white,textSize: 20.0,fontWeight: FontWeight.w400),
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
           onPressed:()=>
           {

           } ,
           elevation: 10.0,
           color: ColorsApp.blue,
         ),


       ],
     );


  }
}