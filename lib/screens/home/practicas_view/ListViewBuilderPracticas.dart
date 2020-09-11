import 'package:flutter/material.dart';
import 'package:practilab/repository/PracticaRepository.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/screens/home/practicas_view/PracticaTile.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:practilab/utilities/models/Practica.dart';

class ListViewBuilderPracticas extends StatefulWidget
{
  List<String> practicas;
  ListViewBuilderPracticas({this.practicas});
  @override
  _ListViewBuilderPracticasState createState() => new _ListViewBuilderPracticasState();
}
class _ListViewBuilderPracticasState extends State<ListViewBuilderPracticas> {
  @override
  Widget build(BuildContext context) {
    if (this.widget.practicas.length == 0) {
      return Center(
        child: TextViewBuilder(
            Strings.SINPRACTICA, colorfont: ColorsApp.blue,
            textSize: 14.0,
            fontWeight: FontWeight.w400),
      );
    }
    else {
      return StreamBuilder<List<Practica>>(
          stream: PracticaRepository(mispracticas: this.widget.practicas).practicas,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("datos ${snapshot.data.length}");
              List<Practica> practicas = snapshot.data;
              return ListView.builder(
                itemCount: practicas.length, // materias.length,
                itemBuilder: (context, index) {
                  PracticaTile practicaTile = PracticaTile(
                      practica: practicas[index].nombre,);
                  return practicaTile;
                },
              );
            }
            else {
              print("no datos ${snapshot.error}");
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20.0,),
                    TextViewBuilder(
                        Strings.BUSCANDOPRACTICAS,
                        colorfont: ColorsApp.blue,
                        textSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ],
                ),
              );
            }
          }
      );
    }
  }
}
