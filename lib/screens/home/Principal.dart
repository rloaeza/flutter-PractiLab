import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practilab/res/values/Animation.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/DrawableValues.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/utilities/Firebase/AuthService/Auth.dart';
import 'package:practilab/utilities/componentes/Decorations.dart';
import 'package:practilab/utilities/Firebase/DataService/Database.dart';
import 'package:practilab/utilities/componentes/ShappingSheet.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:practilab/utilities/componentes/lists/ListViewBuilderMaterias.dart';
import 'package:practilab/utilities/helpers/ImageHelper.dart';
import 'package:practilab/utilities/interfaces/Message.dart';
import 'package:practilab/utilities/interfaces/NotificarEliminacion.dart';
import 'package:practilab/utilities/models/User.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => new _PrincipalState();
 }
class _PrincipalState extends State<Principal> implements Message,NotificarObject
{

   final  AuthService _authService =  AuthService();
   DatabaseUser _databaseUser;
   Alumno alumno;
   String messages="",codeMateria="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authService.setMessageListener(this);
  }
  @override
  Widget build(BuildContext context)
  {
   final user = Provider.of<User>(context);
   _databaseUser = DatabaseUser(uid: user.uid,message: this);
   final _keyaddmateria = GlobalKey<FormFieldState>();
   return  StreamBuilder<Alumno>(
     stream:_databaseUser.alumno,
     builder: (context,snapshot)
     {
       if(snapshot.hasData)
       {
         print("Cantidad de materias ${snapshot.data.materias}");
         alumno = snapshot.data;
           return Scaffold(
             backgroundColor: Colors.transparent,
             body: FadeAnimation(1.5,
                Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: <Widget>[
                   SizedBox(height: 30.0,),
                   Expanded(
                     flex: 1,
                     child: Container(
                       width: MediaQuery
                           .of(context)
                           .size
                           .width,
                       child: Row(
                         children: <Widget>[
                           Padding(
                             padding: EdgeInsets.only(left: 10, right: MediaQuery
                                 .of(context)
                                 .size
                                 .width / 4 ),
                             child: TextViewBuilder(
                                 Strings.TUS_CLASES, colorfont: ColorsApp.white,
                                 textSize: 30.0),),
                           IconButton(
                             icon: Icon(
                               Icons.settings, color: ColorsApp.blue,
                               size: 30.0,),
                             onPressed: () async
                             {
                               showModalBottomSheet(

                                   shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
                                   isScrollControlled: true,
                                   context: context,
                                   builder: (context)
                                   {
                                     return Container(
                                       //height: MediaQuery.of(context).size.height * 0.80,
                                       padding: EdgeInsets.symmetric(vertical: 30.0,horizontal: 30.0),
                                       child: BottonSheet(alumno: alumno,notificarObject: this),
                                     );
                                   });
                             },
                           ),
                           IconButton(
                             icon: Icon(
                               Icons.exit_to_app, color: ColorsApp.blue,
                               size: 30.0,),
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
                       margin: EdgeInsets.only(
                           top: 10, left: 5, right: 5, bottom: 30),
                       child: Card(
                         elevation: 5,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(15.0),
                         ),
                         child: Container(
                           padding: EdgeInsets.all(5),
                           child: ListViewBuilderMaterias(materias: alumno.materias,notificarObject: this,),
                         ),
                       ),
                     ),
                   )
                 ],
               ),
             ),
             floatingActionButton: FloatingActionButton(
               onPressed: () {

                 AlertDialog alertDialog = AlertDialog(
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(15.0),
                   ),
                   title: TextViewBuilder(
                       Strings.INSCRIPCION_CLASE, colorfont: ColorsApp.black_1,
                       textSize: 23),
                   content:
                   Stack(
                       children: <Widget>[
                         Material(
                             elevation: 5,
                             borderRadius: BorderRadius.circular(30),
                             child: Padding(padding: EdgeInsets.symmetric(
                                 vertical: 23, horizontal: 300),)
                         ),
                         TextFormField(
                           key: _keyaddmateria,
                           decoration: Decorations().decorationtext(
                               hintText: Strings.CODIGO_CLASE,
                               colorBorder: ColorsApp.white,
                               colorBorderFocused: ColorsApp.white),
                           validator: (String val) {
                               return val!=null?"Introduce el código de clase":null;
                           },
                           onChanged: (String code)
                           {
                             codeMateria = code;
                           },
                         ),
                       ]
                   ),
                   actions: <Widget>[
                     RaisedButton(
                       child: TextViewBuilder(
                           Strings.CANCELAR, colorfont: ColorsApp.white,
                           textSize: 14.0,
                           fontWeight: FontWeight.w400),
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(30.0)),
                       onPressed: () =>
                       {
                         Navigator.of(context).pop()
                       },
                       elevation: 10.0,
                       color: ColorsApp.blue,
                       padding: EdgeInsets.only(
                           top: 5, bottom: 5, left: 15, right: 15),
                     ),
                     RaisedButton(
                       child: TextViewBuilder(
                           Strings.INSCRIBIRSE, colorfont: ColorsApp.white,
                           textSize: 14.0,
                           fontWeight: FontWeight.w400),
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(30.0)),
                       onPressed: () =>
                       {
                         if(!_evaluarCodigo(codeMateria,alumno.materias))
                         {
                            _databaseUser.updateMateria(codeMateria, alumno.materias),
                            Navigator.of(context).pop()
                         }
                         else{
                           Navigator.of(context).pop(),
                          setState(()
                          {

                            messages="ya tienes registrada esa materia";
                          })
                         }
                       },
                       elevation: 10.0,
                       color: ColorsApp.blue,
                       padding: EdgeInsets.only(
                           top: 5, bottom: 5, left: 15, right: 15),
                     ),
                   ],
                 );
                 showDialog(context: context, child: FadeAnimation(1.5,alertDialog));
               },
               child: Icon(Icons.add, color: ColorsApp.white,),
             ),
         );
       }
       else
       {
          return FadeAnimation(1,
            Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: <Widget>[
               SizedBox(height: 30.0,),
               Expanded(
                 flex: 1,
                 child: Container(
                   width: MediaQuery
                       .of(context)
                       .size
                       .width,
                   child: Row(
                     children: <Widget>[
                     ],
                   ),
                 ),
               ),
               Expanded(
                 flex: 8,
                 child: Container(
                   margin: EdgeInsets.only(
                       top: 10, left: 5, right: 5, bottom: 30),
                   child: Card(
                     elevation: 5,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(15.0),
                     ),
                     child: Container(
                       padding: EdgeInsets.all(5),
                       child:  Center(
                         child: CircularProgressIndicator()
                       )
                     ),
                   ),
                 ),
               )
             ],
         ),
          );
       }
     }
   );

  }

  @override
  void onMessage(String message)
  {
    // TODO: implement onMessage
    setState(() {
      print(" resultado");
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

  bool _evaluarCodigo(String codigo,List<String> materias) {
    bool bandera=false;
    for(int i=0;i<materias.length;i++)
    {
      if(materias[i]==codigo)
      {
        bandera=true;
      }
    }
    return bandera;
  }

  @override
  void setObject(dynamic data)
  {
    if(data is String)
    {
      String idmateria = data as String;
      _databaseUser.deleteMateria(idmateria, alumno.materias);
    }
    else if(data is Alumno)
    {
      Alumno alumno = data;
      _databaseUser.updateUserData(alumno.nombre, alumno.apellido, alumno.telefono, alumno.numeroCtrol);
      setState(() {
        messages=Strings.ACTUALIZADOS;
      });
    }

  }

}
