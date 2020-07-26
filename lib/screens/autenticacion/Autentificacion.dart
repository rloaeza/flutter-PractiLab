import 'package:flutter/material.dart';
import 'package:practilab/screens/autenticacion/Login.dart';
import 'package:practilab/screens/autenticacion/Signup.dart';

class Autentificacion extends StatefulWidget {
  @override
  _AutentificacionState createState() => new _AutentificacionState();
 }
class _AutentificacionState extends State<Autentificacion> {

  bool _showLogin=false;
  Function toggleScreen()
  {
    setState(() {
      _showLogin=!_showLogin;
    });
  }

  @override
  Widget build(BuildContext context)
  {
   return   _showLogin?Login(title:"Login",toggleScreen:toggleScreen):Signup(title:"Registrarse",toggleScreen: toggleScreen);
  }


}