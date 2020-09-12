import 'package:flutter/material.dart';
import 'package:practilab/repository/DataPracticaRepository.dart';
import 'package:practilab/res/values/Animation.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/screens/home/practicas_view/practica/Introduccion.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:practilab/utilities/models/Practica.dart';


class PracticaTile extends StatefulWidget
{
  final  Practica practica;
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
              leading: (this.widget.practica.tipo)?Icon(Icons.group,color: ColorsApp.blue,):Icon(Icons.person,color: ColorsApp.blue,),
              title: TextViewBuilder(this.widget.practica.nombre,colorfont: ColorsApp.blue,textSize: 20.0),
              onTap: ()
              {
                DataPracticaRepository dataPracticaRepository = DataPracticaRepository();
                dataPracticaRepository.practica=this.widget.practica;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PDF(title: Strings.INTRODUCCION)),
                );
                SnackBar s = SnackBar(content: TextViewBuilder(this.widget.practica.uid,colorfont: ColorsApp.white,textSize: 12),);
                Scaffold.of(context).showSnackBar(s);
              },
              trailing: status(this.widget.practica.status),
            ),
            Divider(color: ColorsApp.blue,)
          ]
      ),
    );
  }
Widget status (String status)
{
  if(status=="hecha")
  {
      return Icon(Icons.check,color: ColorsApp.green,);
  }
  else if(status =="nohecha")
  {
      return Icon(Icons.access_time);
  }
  else
  {
      return TextViewBuilder("80/100",colorfont: ColorsApp.green);
  }
}

}