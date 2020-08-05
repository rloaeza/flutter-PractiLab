


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practilab/utilities/Firebase/AuthService/Auth.dart';
import 'package:practilab/utilities/componentes/Decorations.dart';
import 'package:practilab/utilities/componentes/ProgressIndicatorBuilder.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:practilab/utilities/helpers/StringHelper.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/utilities/interfaces/Message.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget
{
  final String title;
  final Function toggleScreen;



  Login({@required this.title,this.toggleScreen});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StateLogin();
  }

}

class _StateLogin  extends State<Login> implements Message
{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _keytextemail = GlobalKey<FormFieldState>();
  final _keytextpass = GlobalKey<FormFieldState>();
  final _keyform = GlobalKey<FormState>();
  final StringHelper _stringHelper = StringHelper();
  final AuthService _authService = AuthService();
  String email="";
  String password="";
  String messages="";
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authService.setMessageListener(this);

  }
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    setSnackBar(messages);

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return loading?ProgressIndicatorBuilder(title: Strings.INGRESANDO):Scaffold(
                key: _scaffoldKey,
                backgroundColor: Colors.transparent,
                body:  SingleChildScrollView(
                    child:  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: Colors.transparent
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(top: 60,left: 33),
                                decoration: BoxDecoration(
                                    color: Colors.transparent
                                ),
                                child: TextViewBuilder(Strings.NAME_APP ,colorfont: ColorsApp.white,textSize: 30.0,fontWeight: FontWeight.w500),
                              )
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 130),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent
                                    ),
                                    child: Form(
                                      key:_keyform ,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                              height: 70,
                                              width: MediaQuery.of(context).size.width/2+100,
                                              child: Stack(
                                                children: <Widget>[
                                                  Material(
                                                    elevation: 5,
                                                    borderRadius: BorderRadius.circular(30),
                                                    child:Padding(padding: EdgeInsets.symmetric(vertical: 23,horizontal: 300),)
                                                  ),
                                                  TextFormField(
                                                    key: _keytextemail,
                                                    enableInteractiveSelection: false,
                                                    keyboardType: TextInputType.emailAddress,
                                                    decoration: Decorations().decorationtext(hintText: Strings.EMAIL,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                                    validator: (String emails)
                                                    {
                                                      return !_stringHelper.isEmail(email)?"No es un email válido. ejem@serv.com!":null;
                                                    },
                                                    onChanged: (String val)
                                                    {
                                                      email=val;
                                                      _keytextemail.currentState.validate();
                                                    },
                                                  ),
                                                ],
                                              )
                                          ),
                                          SizedBox(height: 5,),
                                          SizedBox(
                                              height: 70,
                                              width: MediaQuery.of(context).size.width/2+100,
                                              child: Stack(
                                                  children:<Widget>[
                                                    Material(
                                                        elevation: 5,
                                                        borderRadius: BorderRadius.circular(30),
                                                        child: Padding(padding: EdgeInsets.symmetric(vertical: 23,horizontal: 300),)
                                                    ),
                                                    TextFormField(
                                                      key: _keytextpass,
                                                      enableInteractiveSelection: false,
                                                      obscureText: true,
                                                      decoration: Decorations().decorationtext(hintText: Strings.PASSOWORD,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                                      validator: (String val)
                                                      {
                                                        val=password;
                                                        //print(val);
                                                        return val.isEmpty?"Error, campo vacío":null;
                                                      },
                                                      onChanged: (String pass)
                                                      {
                                                        password=pass;
                                                        _keytextpass.currentState.validate();
                                                      },
                                                    ),
                                                  ]
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width/2+100,
                                        height: 40,
                                        child: RaisedButton(
                                          child: Center(child: TextViewBuilder(Strings.LOGIN,colorfont: ColorsApp.white,textSize: 20.0,fontWeight: FontWeight.w400)),
                                         onPressed: () async
                                          {
                                            //_onLoading();
                                           if( _keyform.currentState.validate())
                                             {
                                               print("ok ${email} & $password");

                                               setState(() {
                                                 loading=true;
                                               });
                                               dynamic result = _authService.signInUserEmailAndPassword(email, password);
                                               if(result != null)
                                               {
                                                 print("no soy null");
                                               }

                                             }
                                           else{
                                             Toast.show("Error en las credenciales, campos inválidos",context);
                                           }
                                          },
                                          color: ColorsApp.blue,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                          elevation: 10,
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width/2+100,
                                        height: 40,
                                        child: RaisedButton(
                                            child: TextViewBuilder(Strings.SIGNUP,colorfont: ColorsApp.white,textSize: 20.0,fontWeight: FontWeight.w400),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                            onPressed:()=>
                                            {
                                             _changeScreen()
                                            } ,
                                            elevation: 10.0,
                                            color: ColorsApp.blue,
                                          ),
                                        ),
                                    ],
                                  ),
                                )
                            )
                          ]
                      )
                    )
                ),
              );





  }

  _changeScreen() {
    this.widget.toggleScreen();
  }

  @override
  void onMessage(String message) {
    // TODO: implement onMessage
    setState(() {
      print(" resultado");
      loading=false;
      messages=message;
    });


  }
  void setSnackBar(String message)
  {
    if(message!="")
    {
      Toast.show(message,context,duration: 2);
      setState(() {
        messages="";
      });
    }
  }

}

