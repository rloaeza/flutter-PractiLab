import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/utilities/Firebase/AuthService/Auth.dart';
import 'package:practilab/utilities/componentes/Decorations.dart';
import 'package:practilab/utilities/componentes/ProgressIndicatorBuilder.dart';
import 'file:///C:/Users/vicen/StudioProjects/Flutter/flutter-PractiLab/lib/utilities/componentes/lists/ListViewBuilderMaterias.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:practilab/utilities/interfaces/Message.dart';
import 'package:practilab/utilities/models/Materia.dart';
import 'package:toast/toast.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => new _PrincipalState();
 }
class _PrincipalState extends State<Principal> implements Message {




 final  AuthService _authService =  AuthService();
 final _keyscaffold = GlobalKey<ScaffoldState>();
 String messages="";
 bool loading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authService.setMessageListener(this);

  }
  @override
  Widget build(BuildContext context) {
   return  loading?ProgressIndicatorBuilder(title: Strings.SALIENDO):Scaffold(

     backgroundColor: Colors.transparent,
     body: Column(
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: <Widget>[
        SizedBox(height: 30.0,),
         Expanded(
           flex: 1,
           child: Container(
             key: _keyscaffold,
             width: MediaQuery.of(context).size.width,
             child: Row(
               children: <Widget>[
                 Padding(
                   padding: EdgeInsets.only(left: 10,right: MediaQuery.of(context).size.width/4+50 ),
                   child:  TextViewBuilder(Strings.TUS_CLASES,colorfont: ColorsApp.white,textSize: 30.0),),
                 IconButton(
                   icon: Icon(Icons.exit_to_app,color: ColorsApp.blue,size: 30.0,),
                   onPressed: () async
                   {
                     setState(() {
                       loading=true;
                     });
                      _authService.singOut();
                   },
                 ),
               ],
             ),
           ),
         ),
         Expanded(
           flex: 8,
           child: Container(
            margin: EdgeInsets.only(top: 10,left: 5,right: 5,bottom: 30),
             child: Card(
               elevation: 5,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(15.0),
               ),
               child: Container(
                   padding: EdgeInsets.all(5),
                   child: ListViewBuilderMaterias(),
               ),
             ),
           ),
         )
       ],
     ),
     floatingActionButton: FloatingActionButton(
       onPressed: () {
         AlertDialog alertDialog = AlertDialog(
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15.0),
           ),
           title: TextViewBuilder(Strings.INSCRIPCION_CLASE,colorfont: ColorsApp.black_1,textSize: 23),
           content:
           Stack(
             children:<Widget>[
               Material(
                 elevation: 5,
                 borderRadius: BorderRadius.circular(30),
                 child: Padding(padding: EdgeInsets.symmetric(vertical: 23,horizontal: 300),)
               ),
               TextFormField(
                 //key: _keytextpass,
                 obscureText: true,
                 decoration: Decorations().decorationtext(hintText: Strings.CODIGO_CLASE,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                 validator: (String val)
                 {

                 },
                 onChanged: (String pass)
                 {

                 },
              ),
             ]
           ),
           actions: <Widget>[
               RaisedButton(
                 child: TextViewBuilder(Strings.CANCELAR,colorfont: ColorsApp.white,textSize: 14.0,fontWeight: FontWeight.w400),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                 onPressed:()=>
                 {
                    Navigator.of(context).pop()
                 },
                 elevation: 10.0,
                 color: ColorsApp.blue,
                 padding: EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 15),
               ),
               RaisedButton(
                 child: TextViewBuilder(Strings.INSCRIBIRSE,colorfont: ColorsApp.white,textSize: 14.0,fontWeight: FontWeight.w400),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                 onPressed:()=>
                 {

                 } ,
                 elevation: 10.0,
                 color: ColorsApp.blue,
                 padding: EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 15),
               ),
           ],
         );
         showDialog(context: context,child: alertDialog);
       },
       child: Icon(Icons.add,color: ColorsApp.white,),
     ),
   );

  }

  @override
  void onMessage(String message)
  {
    // TODO: implement onMessage
    setState(() {
      print(" resultado");
      loading=false;
      messages=message;
    });
  }void setSnackBar(String message)
 {
   if(message!="")
   {
     Toast.show(message,context,duration: 2);
     setState(() {
       messages="";
     });
   }
 }
 @override
 void setState(fn) {
   // TODO: implement setState
   super.setState(fn);
   setSnackBar(messages);

 }
}