import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/utilities/Firebase/AuthService/Auth.dart';
import 'package:practilab/utilities/componentes/Decorations.dart';
import 'package:practilab/utilities/componentes/ProgressIndicatorBuilder.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:practilab/utilities/helpers/StringHelper.dart';
import 'package:practilab/utilities/interfaces/Message.dart';
import 'package:toast/toast.dart';


class Signup extends StatefulWidget {
  final String title;
  final Function toggleScreen;

  Signup({@required this.title,this.toggleScreen});
  @override
  _SignupState createState() => new _SignupState();
 }

class _SignupState extends State<Signup> implements Message
{
  final AuthService _authService = AuthService();

  final _keyform = GlobalKey<FormState>();
  final _keytextemail = GlobalKey<FormFieldState>();
  final _keytextpass = GlobalKey<FormFieldState>();

  final StringHelper _stringHelper = StringHelper();
  String email="",password="",nombre="",apellidos="",telefono="",numCtrol="", messages="";
  bool loading = false;
  @override
  void initState() {
    super.initState();
    _authService.setMessageListener(this);
    BackButtonInterceptor.add(myInterceptor);
  }
  @override
  Widget build(BuildContext context) {
   return loading?ProgressIndicatorBuilder(title: Strings.INGRESANDO):Scaffold(
     backgroundColor: Colors.transparent,
     body: SingleChildScrollView(
           child: Container(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height,
             decoration: BoxDecoration(
               color: Colors.transparent
             ),
             child: SingleChildScrollView(

               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: <Widget>[
                      Row(

                        children: <Widget>[
                          IconButton(
                            padding: EdgeInsets.only(top: 60,),
                            icon: Icon(
                                Icons.arrow_back,
                                color: ColorsApp.white,
                                size: 30.0,
                              ),
                              onPressed: ()
                              {
                                this.widget.toggleScreen();
                              },
                         ),
                          Container(
                            padding: EdgeInsets.only(top: 60,),
                            decoration: BoxDecoration(
                                color: Colors.transparent
                            ),
                            child: TextViewBuilder(Strings.NAME_APP ,colorfont: ColorsApp.white,textSize: 30.0,fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),

                   Container(
                     padding: EdgeInsets.only(top: 80,),
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
                                       enableInteractiveSelection: false,
                                       obscureText: true,
                                       decoration: Decorations().decorationtext(hintText: Strings.PASSOWORDCONFIRM,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                       validator: (String val)
                                       {
                                         return (val.isEmpty || password!=val )?"Error no coinciden las contraseñas":null;
                                       },
                                     ),
                                   ]
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
                                       enableInteractiveSelection: false,
                                       textCapitalization: TextCapitalization.words,
                                       decoration: Decorations().decorationtext(hintText: Strings.NAME,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                       validator: (String val)
                                       {
                                         return val.isEmpty?"Este campo no puede estar vacío":null;
                                       },
                                       onChanged: (val)
                                       {
                                         nombre=val;
                                       },

                                     ),
                                   ]
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
                                       enableInteractiveSelection: false,
                                       textCapitalization: TextCapitalization.words,
                                       decoration: Decorations().decorationtext(hintText: Strings.LASTNAME,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                       validator: (String val)
                                       {
                                         return val.isEmpty?"Este campo no puede estar vacío":null;
                                       },
                                       onChanged: (val){
                                         apellidos=val;
                                       },
                                     ),
                                   ]
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
                                       enableInteractiveSelection: false,
                                       keyboardType: TextInputType.number,
                                       decoration: Decorations().decorationtext(hintText: Strings.CTRL_NUMBER,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                       validator: (String val)
                                       {
                                         return (val.isEmpty || val.length<8)?"Este campo debe de tener 8 dígitos":null;
                                       },
                                       onChanged: (val)
                                       {
                                         numCtrol=val;
                                       },
                                       maxLength: 8,
                                     ),
                                   ]
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
                                       keyboardType: TextInputType.number,
                                       enableInteractiveSelection: false,
                                       decoration: Decorations().decorationtext(hintText: Strings.PHONE,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                       validator: (String val)
                                       {
                                         return (val.isEmpty ||val.length<10)?"Este campo debe de tener 10 dígitos":null;
                                       },
                                       onChanged: (val)
                                       {
                                         telefono=val;
                                       },
                                       maxLength: 10,
                                     ),
                                   ]
                               )
                           ),
                           SizedBox(height: 5,),
                           Container(
                             padding: EdgeInsets.only(bottom: 20.0),
                             child: SizedBox(

                               width: MediaQuery.of(context).size.width/2+100,
                               height: 40,
                               child: RaisedButton(
                                 child: TextViewBuilder(Strings.SIGNUP,colorfont: ColorsApp.white,textSize: 20.0,fontWeight: FontWeight.w400),
                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                 onPressed:() async
                                 {
                                  // _changeScreen()
                                   if(_keyform.currentState.validate())
                                   {
                                     if( _stringHelper.numberString(telefono) && _stringHelper.numberString(numCtrol))
                                     {
                                       print("entre");
                                       setState(() {
                                         loading=true;
                                       });
                                       dynamic result = await _authService.registerUserEmailAndPassword(email, password,nombre,apellidos,telefono,numCtrol);
                                       if(result==null)
                                       {

                                         setState(() {
                                           loading=false;
                                         });
                                       }
                                     }
                                     else
                                     {
                                       setState(() {
                                         messages="Campo número de control o teléfono contienen letras";
                                       });

                                     }
                                   }
                                 } ,
                                 elevation: 10.0,
                                 color: ColorsApp.blue,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                 ]
               ),
             ),
           ),
         ),
   );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    BackButtonInterceptor.remove(myInterceptor);
  }
  bool myInterceptor(bool stopDefaultButtonEvent,RouteInfo info) {
    this.widget.toggleScreen();
    return true;
  }

  @override
  void onMessage(String message) {
    // TODO: implement onMessage
    //Toast.show(message, context,);
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
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    setSnackBar(messages);

  }
}