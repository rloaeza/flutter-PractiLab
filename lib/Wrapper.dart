import 'package:flutter/material.dart';
import 'package:practilab/screens/Home/Principal.dart';
import 'package:practilab/screens/autenticacion/Autentificacion.dart';
import 'package:practilab/utilities/models/User.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
 @override
 Widget build(BuildContext context)
 {
   final user = Provider.of<User>(context);
   return  user==null?Autentificacion():Principal();
 }
}