
import 'package:flutter/material.dart';
import 'package:practilab/res/values/Colors.dart';

class ProgressIndicatorBuilder extends StatelessWidget
{
  String title;
  ProgressIndicatorBuilder({this.title});
 @override
 Widget build(BuildContext context) {
  return  Stack(
      children: <Widget>[
        new Container(
          alignment: AlignmentDirectional.center,
          decoration: new BoxDecoration(
            color: Colors.white70,
          ),
          child: new Container(
            decoration: new BoxDecoration(
                color: ColorsApp.yelow,
                borderRadius: new BorderRadius.circular(10.0)
            ),
            width: 300.0,
            height: 200.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: new CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                      backgroundColor: ColorsApp.blue,
                    ),
                  ),
                ),
               Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: new Center(
                    child: new Text(
                      title,
                      style: new TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
  );
 }
}