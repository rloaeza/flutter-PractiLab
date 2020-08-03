import 'package:flutter/material.dart';
import 'package:practilab/utilities/componentes/tiles/MateriaTile.dart';
import 'package:practilab/utilities/models/Materia.dart';

class ListViewBuilderMaterias extends StatefulWidget {
  @override
  _ListViewBuilderMateriasState createState() => new _ListViewBuilderMateriasState();
 }
class _ListViewBuilderMateriasState extends State<ListViewBuilderMaterias> {
  List<Materia> materiaItems = [
    Materia(nombre: "Química", cantidadPracticas: 5),
    Materia(nombre: "Redes de computadoras", cantidadPracticas: 5),
    Materia(nombre: "Fundamentos de BBDD", cantidadPracticas: 2),
    Materia(nombre: "Física", cantidadPracticas: 6),
    Materia(nombre: "Electrónica 2", cantidadPracticas: 5),
    Materia(nombre: "Cemento 1", cantidadPracticas: 1),
    Materia(nombre: "Taller de Administración", cantidadPracticas: 9),
    Materia(nombre: "Química orgánica", cantidadPracticas: 7)];

  //final materias = [];//Provider.of<<List<Materias>>(context)??[];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: materiaItems.length, // materias.length,
      itemBuilder: (context, index) {
        return MateriaTile(materia: materiaItems[index],);
      },
    );
  }
}




/*Widget listViewBuilder({BuildContext context, List<Materia> materiaItems, Function onTap})
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
                  color: ColorsApp.blue,
                size: 35,),
                onPressed: ()
                {
                  SnackBar s = SnackBar(content: TextViewBuilder("mensaje",colorfont: ColorsApp.white,textSize: 12),);
                  Scaffold.of(context).showSnackBar(s);
                }),
              title: TextViewBuilder(materiaItems[index].nombre,colorfont: ColorsApp.blue,textSize: 20.0),
              subtitle: TextViewBuilderElipsis(praticas(materiaItems[index].cantidadPracticas),colorfont: ColorsApp.blue,textSize: 12.0),
              onTap: onTap,
            ),
            Divider(color: ColorsApp.blue,)
          ]
        );
      }

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
}*/