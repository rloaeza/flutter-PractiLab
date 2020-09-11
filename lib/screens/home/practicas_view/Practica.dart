import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practilab/bloc/auth_bloc/auth_bloc.dart';
import 'package:practilab/res/values/Animation.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/screens/home/practicas_view/ListViewBuilderPracticas.dart';
import 'package:practilab/utilities/componentes/Decorations.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:transparent_image/transparent_image.dart';



class PracticaScreen extends StatelessWidget
{
  final String title;
  final List<String> practicas;

  const PracticaScreen({Key key, this.title,this.practicas}) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Practica(title: title,practicas: this.practicas,),
    );
  }
}

class Practica extends StatefulWidget
{
  final String title;
  final List<String> practicas;
  Practica({Key key,@required this.title,this.practicas}):super(key:key);
  @override
  _PracticaState createState() => new _PracticaState();
}
class _PracticaState extends State<Practica>
{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
                  backgroundColor: Colors.transparent,
                  body:Stack(
                      children: <Widget>[
                      Container(
                      decoration: BoxDecoration(
                          color: ColorsApp.yelow
                      ),
                      ),
                      FadeInImage.memoryNetwork(
                      fadeInDuration:  Duration(milliseconds: 500),
                      placeholder: kTransparentImage,//DrawableValues.BACKGROUND_IMAGE,
                      image: "https://firebasestorage.googleapis.com/v0/b/practilab-itsu.appspot.com/o/background.png?alt=media&token=20ac8e79-6e87-459f-982f-0eb902e5d83d",
                      ),
                    FadeAnimation(1.5,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(height: 30.0,),
                          Expanded(
                              flex: 1,
                              child: headerPractica()
                          ),
                          Expanded(
                            flex: 8,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 10,
                                  left: 5,
                                  right: 5,
                                  bottom: 30),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      15.0),
                                ),
                                  child:Container(
                                    padding: EdgeInsets.all(5),
                                    child: ListViewBuilderPracticas(practicas: this.widget.practicas,),
                                  )
                                ),
                              ),
                            ),
                        ],
                      ),
                  ),
                      ]
              ),
        floatingActionButton: floatingButton()
    );


  }

  Widget headerPractica()
  {
    return Row(
      children: <Widget>[
        IconButton(
          padding: EdgeInsets.only(top: 10,),
          icon: Icon(
            Icons.arrow_back,
            color: ColorsApp.white,
            size: 30.0,
          ),
          onPressed: ()
          {
            Navigator.of(context).pop();
          },

        ),
        Container(
          padding: EdgeInsets.only(top: 10,),
          decoration: BoxDecoration(
              color: Colors.transparent
          ),
          child: TextViewBuilder(Strings.TU_MATERIA ,colorfont: ColorsApp.white,textSize: 30.0,fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget floatingButton()
  {
    return FloatingActionButton(
      onPressed: () {
        AlertDialog alertDialog = AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: TextViewBuilder(
              Strings.MENSAJE, colorfont: ColorsApp.black_1,
              textSize: 23),
          content:
          Stack(
              children: <Widget>[
                Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    child: Padding(padding: EdgeInsets.symmetric(
                        vertical: 23, horizontal: 300),)
                ),
                TextFormField(

                  decoration: Decorations().decorationtext(
                      hintText: Strings.MENSAJE,
                      colorBorder: ColorsApp.white,
                      colorBorderFocused: ColorsApp.white),

                ),
              ]
          ),
          actions: <Widget>[

            RaisedButton(
              child: TextViewBuilder(
                  Strings.ENVIAR, colorfont: ColorsApp.white,
                  textSize: 14.0,
                  fontWeight: FontWeight.w400),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              onPressed: () =>
              {

              },
              elevation: 10.0,
              color: ColorsApp.blue,
              padding: EdgeInsets.only(
                  top: 5, bottom: 5, left: 15, right: 15),
            ),RaisedButton(
              child: TextViewBuilder(
                  Strings.CANCELAR, colorfont: ColorsApp.white,
                  textSize: 14.0,
                  fontWeight: FontWeight.w400),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              onPressed: () =>
              {
                Navigator.of(context).pop()
              },
              elevation: 10.0,
              color: ColorsApp.blue,
              padding: EdgeInsets.only(
                  top: 5, bottom: 5, left: 15, right: 15),
            ),
          ],
        );
        showDialog(
            context: context, child: FadeAnimation(1.5, alertDialog));
      },
      child: Icon(Icons.message, color: ColorsApp.white,),
    );
  }

}
