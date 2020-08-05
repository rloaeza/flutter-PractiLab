import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/utilities/componentes/Decorations.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:practilab/utilities/helpers/StringHelper.dart';
import 'package:practilab/utilities/interfaces/NotificarEliminacion.dart';
import 'package:practilab/utilities/models/User.dart';





class BottonSheet extends StatefulWidget
{
  NotificarObject notificarObject;
  Alumno alumno;
  BottonSheet({this.alumno,this.notificarObject});
  @override
  _BottonSheetState createState() => new _BottonSheetState();

 }
class _BottonSheetState extends State<BottonSheet> {
  String _nombre="";
  String _apellidos="";
  String _numCtrol="";
  String _telefono="";
  final StringHelper _stringHelper = StringHelper();
  final _keyform = GlobalKey<FormState>();
  final _keytexttel = GlobalKey<FormFieldState>();
  final _keytextnumctrol = GlobalKey<FormFieldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nombre=this.widget.alumno.nombre??"";
    _apellidos=this.widget.alumno.apellido??"";
    _telefono=this.widget.alumno.telefono??"";
    _numCtrol=this.widget.alumno.numeroCtrol??"";
  }
  @override
  Widget build(BuildContext context)
  {
    final alumno = this.widget.alumno;
     return Form(
       key: _keyform,
       child: ListView(
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
                       initialValue: alumno.nombre,
                       enableInteractiveSelection: false,
                       textCapitalization: TextCapitalization.words,
                       decoration: Decorations().decorationtext(hintText: Strings.NAME,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                       validator: (String val)
                       {
                         return val.isEmpty?"Error, campo vacío":null;
                       },
                       onChanged: (String nom)
                       {
                         _nombre=nom;
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
                       initialValue: alumno.apellido,
                       enableInteractiveSelection: false,
                       textCapitalization: TextCapitalization.words,
                       decoration: Decorations().decorationtext(hintText: Strings.LASTNAME,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                       validator: (String val)
                       {
                         return val.isEmpty?"Error, campo vacío":null;
                       },
                       onChanged: (String apellidos)
                       {
                         _apellidos=apellidos;
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
                       key: _keytextnumctrol,
                       enableInteractiveSelection: false,
                       keyboardType: TextInputType.number,
                       initialValue: alumno.numeroCtrol,
                       decoration: Decorations().decorationtext(hintText: Strings.CTRL_NUMBER,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                       validator: (String val)
                       {
                         val=_numCtrol;
                         if(val.isEmpty)
                         {
                             return "El campo está vacío";
                         }
                         else if(!_stringHelper.numberString(val)){
                           return "Eso no es un numero de control";
                         }
                         else if(val.length!=8)
                         {
                           return "Debe de tener 8 dígitos el número de control";
                         }
                         else{
                           return null;
                         }
                       },
                       onChanged: (String ctrol)
                       {
                         _numCtrol=ctrol;
                         _keytextnumctrol.currentState.validate();
                       },
                       maxLength: 8,
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
                       key: _keytexttel,
                       enableInteractiveSelection: false,
                       keyboardType: TextInputType.number,
                       initialValue: alumno.telefono,
                       decoration: Decorations().decorationtext(hintText: Strings.PHONE,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                       validator: (String val)
                       {
                         val=_telefono;
                         if(val.isEmpty)
                         {
                           return "El campo está vacío";
                         }
                         else if(!_stringHelper.numberString(val))
                         {
                           return "Eso no es un teléfono.";
                         }
                         else if(val.length<10)
                         {
                          return "Debe de tener 10 dígitos.";
                         }
                         else
                         {
                           return null;
                         }
                       },
                       onChanged: (String telefono)
                       {
                         _telefono=telefono;
                         print(_telefono);
                         _keytexttel.currentState.validate();
                       },
                       maxLength: 10,
                     ),
                   ]
               )
           ),
           SizedBox(height: 20.0,),
           RaisedButton(
             child: TextViewBuilder(Strings.ACTUALIZAR,colorfont: ColorsApp.white,textSize: 20.0,fontWeight: FontWeight.w400),
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
             onPressed:()=>
             {

                if(_keyform.currentState.validate())
                {
                  alumno.nombre=_nombre,
                  alumno.apellido=_apellidos,
                  alumno.telefono=_telefono,
                  alumno.numeroCtrol=_numCtrol,
                  widget.notificarObject.setObject(alumno),
                  Navigator.of(context).pop()
                }
             } ,
             elevation: 10.0,
             color: ColorsApp.blue,
           ),


         ],
       ),
     );


  }
}