import 'package:flutter/material.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:practilab/utilities/models/Materia.dart';

Widget ListViewBuilder(BuildContext context, List<Materia> materiaItems)
{
  return ListView.builder(
      itemCount: materiaItems.length,
      itemBuilder: (context,index)
      {
        return Column(
          children: <Widget>[
            ListTile(
              trailing: IconButton(
                icon:Icon(Icons.message,
                  color: ColorsApp.blue, ),
                onPressed: ()
                {
                  SnackBar s = SnackBar(content: TextViewBuilder("mensaje",colorfont: ColorsApp.white,textSize: 12),);
                  Scaffold.of(context).showSnackBar(s);
                }),
              title: TextViewBuilder(materiaItems[index].nombre,colorfont: ColorsApp.blue,textSize: 25.0),
              subtitle: TextViewBuilderElipsis(praticas(materiaItems[index].cantidadPracticas),colorfont: ColorsApp.blue,textSize: 12.0),

            ),
            Divider(color: ColorsApp.blue,)
          ],
        );
      }
  );
}

String praticas(int cantidad)
{
  String practicas="";
  for(int practica=0;practica<cantidad;practica++)
  {
      practicas+="Práctica ${practica+1}, ";
  }
  return practicas;
}