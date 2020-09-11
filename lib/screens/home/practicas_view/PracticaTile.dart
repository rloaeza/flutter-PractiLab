import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practilab/bloc/auth_bloc/update_data_bloc/update_bloc.dart';
import 'package:practilab/res/values/Animation.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:practilab/utilities/helpers/SearchHelper.dart';
import 'package:practilab/utilities/models/Materia.dart';


class PracticaTile extends StatefulWidget
{
  final  String practica;
  PracticaTile({this.practica});
  @override
  _PracticaTileState createState() => new _PracticaTileState();

 }
class _PracticaTileState extends State<PracticaTile>
{
  @override
  void initState() {
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
              title: TextViewBuilder(this.widget.practica,colorfont: ColorsApp.blue,textSize: 20.0),
              onTap: ()
              {
                SnackBar s = SnackBar(content: TextViewBuilder("Hola",colorfont: ColorsApp.white,textSize: 12),);
                Scaffold.of(context).showSnackBar(s);
              },
            ),
            Divider(color: ColorsApp.blue,)
          ]
      ),
    );
  }


}