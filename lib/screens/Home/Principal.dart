import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/utilities/Firebase/AuthService/Auth.dart';
import 'package:practilab/utilities/componentes/Decorations.dart';
import 'package:practilab/utilities/componentes/ListViewBuilder.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:practilab/utilities/interfaces/Message.dart';
import 'package:practilab/utilities/models/Materia.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => new _PrincipalState();
 }
class _PrincipalState extends State<Principal> implements Message {

  List<Materia> materiaItems= [
    Materia(nombre: "Química",cantidadPracticas: 5),
    Materia(nombre: "Redes de computadoras",cantidadPracticas: 5),
    Materia(nombre: "Fundamentos de BBDD",cantidadPracticas: 2),
    Materia(nombre: "Física",cantidadPracticas: 6),
    Materia(nombre: "Electrónica 2",cantidadPracticas: 5),
    Materia(nombre: "Cemento 1",cantidadPracticas: 1),
    Materia(nombre: "Taller de Administración",cantidadPracticas: 9),
    Materia(nombre: "Química orgánica",cantidadPracticas: 7)];


 final  AuthService _authService =  AuthService();
 final _keyscaffold = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authService.setMessageListener(this);
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(

     backgroundColor: Colors.transparent,
     body: Column(
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: <Widget>[
        SizedBox(height: 30.0,),
         Expanded(
           flex: 1,
           child: Container(
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
                   key:  _keyscaffold,
                   padding: EdgeInsets.all(5),
                   child: listViewBuilder(
                     context: context,
                     materiaItems: materiaItems,
                     onTap: (){
                       SnackBar s = SnackBar(content: TextViewBuilder("Hola",colorfont: ColorsApp.white,textSize: 12),);
                       Scaffold.of(_keyscaffold.currentContext).showSnackBar(s);
                     }
                   ),
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
    SnackBar s = SnackBar(content: TextViewBuilder(message,colorfont: ColorsApp.white,textSize: 12),);
    Scaffold.of(_keyscaffold.currentContext).showSnackBar(s);
    print(message);
  }
}