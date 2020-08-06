import 'package:flutter/material.dart';
import 'package:practilab/Wrapper.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/DrawableValues.dart';
import 'package:practilab/utilities/Firebase/AuthService/Auth.dart';
import 'package:practilab/utilities/helpers/ImageHelper.dart';
import 'package:practilab/utilities/models/User.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: ColorsApp.yelow,
      //backgroundColor: ColorsApp.yelow,
      primaryColorLight: ColorsApp.yelow),
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: ColorsApp.yelow
            ),
          ),
          FadeInImage.memoryNetwork(
            fadeInDuration:  Duration(milliseconds: 1000),
            placeholder: kTransparentImage,//DrawableValues.BACKGROUND_IMAGE,
            image: "https://firebasestorage.googleapis.com/v0/b/practilab-itsu.appspot.com/o/background.png?alt=media&token=20ac8e79-6e87-459f-982f-0eb902e5d83d",
          ),
          StreamProvider<User>.value(
                      value: AuthService().user,
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Container(
                          /*decoration: BoxDecoration(
                            image: DecorationImage(
                            fit: BoxFit.cover,
                            image: ImageHelper.getAsset(DrawableValues.BACKGROUND_IMAGE)
                            )
                          )*/
                        child: Wrapper(),
                      ),
                  )
            ),
        ],
      )
    );

  }
}


