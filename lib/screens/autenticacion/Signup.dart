import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/utilities/componentes/Decorations.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';

class Signup extends StatefulWidget {
  final String title;
  final Function toggleScreen;

  Signup({@required this.title,this.toggleScreen});
  @override
  _SignupState createState() => new _SignupState();
 }
class _SignupState extends State<Signup> {
  final _keyform = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.transparent,
     body: SingleChildScrollView(
           child: Container(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height,
             decoration: BoxDecoration(
               color: Colors.transparent
             ),
             child: SingleChildScrollView(

               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: <Widget>[
                      Row(

                        children: <Widget>[
                          IconButton(
                            padding: EdgeInsets.only(top: 60,),
                            icon: Icon(
                                Icons.arrow_back,
                                color: ColorsApp.white,
                                size: 30.0,
                              ),
                              onPressed: ()
                              {
                                this.widget.toggleScreen();
                              },
                         ),
                          Container(
                            padding: EdgeInsets.only(top: 60,),
                            decoration: BoxDecoration(
                                color: Colors.transparent
                            ),
                            child: TextViewBuilder(Strings.NAME_APP ,colorfont: ColorsApp.white,textSize: 30.0,fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),

                   Container(
                     padding: EdgeInsets.only(top: 80,),
                     child: Form(
                       key:_keyform ,

                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                           SizedBox(
                               height: 70,
                               width: MediaQuery.of(context).size.width/2+100,
                               child: Stack(
                                 children: <Widget>[
                                   Material(
                                       elevation: 5,
                                       borderRadius: BorderRadius.circular(30),
                                       child:Padding(padding: EdgeInsets.symmetric(vertical: 23,horizontal: 300),)
                                   ),
                                   TextFormField(
                                     keyboardType: TextInputType.emailAddress,
                                     decoration: Decorations().decorationtext(hintText: Strings.EMAIL,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                     /*decoration: InputDecoration(
                                                        hintText: Strings.EMAIL,
                                                        helperStyle: Decorations().styleTextView(color: ColorsApp.black,textSize: 10.0,fontWeight: FontWeight.w500)
                                                    ),*/
                                     validator: (String val)
                                     {
                                       return val.isEmpty?"Error":null;
                                     },
                                   ),
                                 ],
                               )
                           ),
                           SizedBox(height: 5,),
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
                                       obscureText: true,
                                       decoration: Decorations().decorationtext(hintText: Strings.PASSOWORD,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                       validator: (String val)
                                       {
                                         return val.isEmpty?"Error":null;
                                       },
                                     ),
                                   ]
                               )
                           ),
                           SizedBox(height: 5,),
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
                                       obscureText: true,
                                       decoration: Decorations().decorationtext(hintText: Strings.PASSOWORD,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                       validator: (String val)
                                       {
                                         return val.isEmpty?"Error":null;
                                       },
                                     ),
                                   ]
                               )
                           ),
                           SizedBox(height: 5,),
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
                                       obscureText: true,
                                       decoration: Decorations().decorationtext(hintText: Strings.NAME,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                       validator: (String val)
                                       {
                                         return val.isEmpty?"Error":null;
                                       },
                                     ),
                                   ]
                               )
                           ),
                           SizedBox(height: 5,),
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
                                       obscureText: true,
                                       decoration: Decorations().decorationtext(hintText: Strings.LASTNAME,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                       validator: (String val)
                                       {
                                         return val.isEmpty?"Error":null;
                                       },
                                     ),
                                   ]
                               )
                           ),
                           SizedBox(height: 5,),
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
                                       obscureText: true,
                                       decoration: Decorations().decorationtext(hintText: Strings.CTRL_NUMBER,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                       validator: (String val)
                                       {
                                         return val.isEmpty?"Error":null;
                                       },
                                     ),
                                   ]
                               )
                           ),
                           SizedBox(height: 5,),
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
                                       obscureText: true,
                                       decoration: Decorations().decorationtext(hintText: Strings.PHONE,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                       validator: (String val)
                                       {
                                         return val.isEmpty?"Error":null;
                                       },
                                     ),
                                   ]
                               )
                           ),
                           SizedBox(height: 5,),
                           Container(
                             padding: EdgeInsets.only(bottom: 20.0),
                             child: SizedBox(

                               width: MediaQuery.of(context).size.width/2+100,
                               height: 40,
                               child: RaisedButton(
                                 child: TextViewBuilder(Strings.SIGNUP,colorfont: ColorsApp.white,textSize: 20.0,fontWeight: FontWeight.w400),
                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                 onPressed:()=>
                                 {
                                  // _changeScreen()
                                 } ,
                                 elevation: 10.0,
                                 color: ColorsApp.blue,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                 ]
               ),
             ),
           ),
         ),
   );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    BackButtonInterceptor.remove(myInterceptor);
  }
  bool myInterceptor(bool stopDefaultButtonEvent) {
    this.widget.toggleScreen();
    return true;
  }

}