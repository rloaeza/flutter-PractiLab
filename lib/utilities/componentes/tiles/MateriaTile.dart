import 'package:flutter/material.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/utilities/models/Materia.dart';

import '../TextViewBuilder.dart';

class MateriaTile extends StatefulWidget
{
  final Materia materia;
  MateriaTile({this.materia});
  @override
  _MateriaTileState createState() => new _MateriaTileState();
 }
class _MateriaTileState extends State<MateriaTile>
{


  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          ListTile(
            trailing: IconButton(
                icon:Icon(Icons.message,
                  color: ColorsApp.blue,
                  size: 35,),
                onPressed: ()
                {
                  SnackBar s = SnackBar(content: TextViewBuilder("mensaje",colorfont: ColorsApp.white,textSize: 12),);
                  Scaffold.of(context).showSnackBar(s);
                }),
            title: TextViewBuilder(this.widget.materia.nombre,colorfont: ColorsApp.blue,textSize: 20.0),
            subtitle: TextViewBuilderElipsis(praticas(this.widget.materia.cantidadPracticas),colorfont: ColorsApp.blue,textSize: 12.0),
            onTap: ()
            {
              SnackBar s = SnackBar(content: TextViewBuilder("Hola",colorfont: ColorsApp.white,textSize: 12),);
              Scaffold.of(context).showSnackBar(s);
            },
          ),
          Divider(color: ColorsApp.blue,)
        ]
    );
  }
  String praticas(int cantidad)
  {
    String practicas="";
    for(int practica=0;practica<cantidad;practica++)
    {
      if(practica==cantidad-1)
      {
        practicas+="Práctica ${practica+1}. ";
      }
      else
      {
        practicas+="Práctica ${practica+1}, ";
      }

    }
    return practicas;
  }
}