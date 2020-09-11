import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practilab/bloc/auth_bloc/update_data_bloc/update_bloc.dart';
import 'package:practilab/res/values/Animation.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/screens/home/practicas_view/Practica.dart';
import 'package:practilab/utilities/helpers/SearchHelper.dart';
import 'package:practilab/utilities/interfaces/NotificarEliminacion.dart';
import 'package:practilab/utilities/models/Materia.dart';
import 'package:practilab/utilities/models/Users.dart';
import 'package:provider/provider.dart';

import '../../../utilities/componentes/TextViewBuilder.dart';

class MateriaTile extends StatefulWidget
{
  final  List<String> materias;
  final Materia materia;
  MateriaTile({this.materia, this.materias});
  @override
  _MateriaTileState createState() => new _MateriaTileState();

 }
class _MateriaTileState extends State<MateriaTile>
{
  UpdateBloc _updateBloc;
  @override
  void initState() {
    _updateBloc = BlocProvider.of<UpdateBloc>(context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context)
  {

    return FadeAnimation(2,
       Column(
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
              subtitle: TextViewBuilderElipsis(SearchHelper().praticasContador(this.widget.materia.cantidadPracticas),colorfont: ColorsApp.blue,textSize: 12.0),
              onTap: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PracticaScreen(title: Strings.TU_MATERIA,practicas:this.widget.materia.practicas)),
                );

              },
              onLongPress: (){
                confirmarEliminacion(context);

              },
            ),
            Divider(color: ColorsApp.blue,)
          ]
      ),
    );
  }
  Widget confirmarEliminacion(BuildContext context)
  {
    showDialog(context:context,
      builder: (context)
        {
          return  AlertDialog(
            title: Text('Eliminación de materia'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('¿Estás seguro de querer eliminar la materia?'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Eliminar'),
                onPressed: ()
                {
                  _updateBloc.add(DeleteSubjects(materia: this.widget.materia.uid,materias: this.widget.materias));
                  // _databaseUser.deleteMateria(idmateria, alumno.materias);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
    //SnackBar s = SnackBar(content: TextViewBuilder(this.widget.materia.uid+"",colorfont: ColorsApp.white,textSize: 12),);
    //Scaffold.of(context).showSnackBar(s);
    return null;
  }


}