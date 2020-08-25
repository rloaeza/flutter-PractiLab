
import 'package:flutter/material.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/utilities/Firebase/DataService/Database.dart';
import 'package:practilab/utilities/Firebase/DataService/DatabaseMateria.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:practilab/utilities/componentes/tiles/MateriaTile.dart';
import 'package:practilab/utilities/interfaces/Message.dart';
import 'package:practilab/utilities/interfaces/NotificarEliminacion.dart';
import 'package:practilab/utilities/models/Materia.dart';
import 'package:practilab/utilities/models/User.dart';
import 'package:provider/provider.dart';


class ListViewBuilderMaterias extends StatefulWidget
{
  NotificarObject notificarObject;
  List<dynamic> materias;
  ListViewBuilderMaterias({this.materias,this.notificarObject});
  @override
  _ListViewBuilderMateriasState createState() => new _ListViewBuilderMateriasState();


}
class _ListViewBuilderMateriasState extends State<ListViewBuilderMaterias>
{

  @override
  Widget build(BuildContext context)
  {
    return StreamBuilder<List<Materia>>(
      stream: DatabaseMateria(mismaterias: this.widget.materias).materias,
      builder: (context, snapshot)
      {
        if(snapshot.hasData)
        {
          print("datos ${snapshot.data.length}");
          List<Materia> materias = snapshot.data;
          return ListView.builder(
            itemCount:materias.length, // materias.length,
            itemBuilder: (context, index)
            {
              MateriaTile materiaTile = MateriaTile(materia: materias[index],);
              materiaTile.setNotificarObjectListener(this.widget.notificarObject);
              return materiaTile;
            },
          );
        }
        else{
          print("no datos ${snapshot.error}");
          return Center(
             child: TextViewBuilder(
                 Strings.SINMATERIA, colorfont: ColorsApp.blue,
                 textSize: 14.0,
                 fontWeight: FontWeight.w400),
          );
        }
      }
    );
  }










}
