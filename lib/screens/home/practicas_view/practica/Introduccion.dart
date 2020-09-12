import 'package:flutter/material.dart';
import 'package:practilab/repository/DataPracticaRepository.dart';
import 'package:practilab/res/values/Animation.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/screens/home/practicas_view/ListViewBuilderPracticas.dart';
import 'package:practilab/utilities/componentes/Decorations.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:transparent_image/transparent_image.dart';




class PDF extends StatefulWidget
{
  final String title;
  PDF({Key key, this.title}):super(key:key);
  @override
  _PDFState createState() => new _PDFState();
}
class _PDFState extends State<PDF>
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
                              child: Text("Introduccion ${DataPracticaRepository().practica.tipo}")
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
          child: TextViewBuilder(this.widget.title ,colorfont: ColorsApp.white,textSize: 30.0,fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget floatingButton()
  {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Icon(Icons.home, color: ColorsApp.white,),
    );
  }

}
