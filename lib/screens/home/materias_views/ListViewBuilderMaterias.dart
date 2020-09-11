
import 'package:flutter/material.dart';
import 'package:practilab/repository/MateriaRepository.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/screens/home/materias_views/MateriaTile.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:practilab/utilities/models/Materia.dart';

class ListViewBuilderMaterias extends StatefulWidget
{

  List<dynamic> materias;
  ListViewBuilderMaterias({this.materias});
  @override
  _ListViewBuilderMateriasState createState() => new _ListViewBuilderMateriasState();


}
class _ListViewBuilderMateriasState extends State<ListViewBuilderMaterias> {
  @override
  Widget build(BuildContext context) {
    if (this.widget.materias.length == 0) {
      return Center(
        child: TextViewBuilder(
            Strings.SINMATERIA, colorfont: ColorsApp.blue,
            textSize: 14.0,
            fontWeight: FontWeight.w400),
      );
    }
    else {
      return StreamBuilder<List<Materia>>(
          stream: MateriaRepository(mismaterias: this.widget.materias).materias,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("datos ${snapshot.data.length}");
              List<Materia> materias = snapshot.data;
              return ListView.builder(
                itemCount: materias.length, // materias.length,
                itemBuilder: (context, index) {
                  MateriaTile materiaTile = MateriaTile(
                    materia: materias[index], materias: this.widget.materias.cast<String>());
                  return materiaTile;
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
                        Strings.BUSCANDOMATERIAS, colorfont: ColorsApp.blue,
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
