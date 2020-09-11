import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practilab/bloc/auth_bloc/auth_bloc.dart';
import 'package:practilab/bloc/auth_bloc/update_data_bloc/update_bloc.dart';
import 'package:practilab/repository/StudentRepository.dart';
import 'package:practilab/res/values/Animation.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/screens/home/materias_views/ListViewBuilderMaterias.dart';
import 'package:practilab/utilities/componentes/Decorations.dart';
import 'package:practilab/utilities/componentes/ShappingSheet.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:practilab/utilities/componentes/Toast.dart';
import 'package:practilab/utilities/helpers/SearchHelper.dart';
import 'package:practilab/utilities/interfaces/Message.dart';
import 'package:practilab/utilities/models/Alumno.dart';
import 'package:practilab/utilities/models/Users.dart';

class HomeScreen extends StatelessWidget
{
  final String title;
  final Users user;
  final StudentRepository studentRepository;
  const HomeScreen({Key key, this.title, this.user, this.studentRepository}) : super(key: key);
 @override
 Widget build(BuildContext context)
 {
   return Scaffold(
     backgroundColor: Colors.transparent,
     body: BlocProvider<UpdateBloc>(
       create: (context)=>UpdateBloc(studentRepository: studentRepository),
       child: Principal(title: title,user: user,studentRepository: studentRepository)
     ),
   );
 }
}

class Principal extends StatefulWidget
{
  final String title;
  final Users user;
  final StudentRepository studentRepository;
  Principal({Key key,@required this.title,@required this.user,@required this.studentRepository}):super(key:key);
  @override
  _PrincipalState createState() => new _PrincipalState();
 }
class _PrincipalState extends State<Principal> implements Message {

  UpdateBloc _updateBloc;
  Alumno alumno;
  String messages = "", codeMateria = "";
  final _keyaddmateria = GlobalKey<FormFieldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateBloc = BlocProvider.of<UpdateBloc>(context);
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<UpdateBloc,UpdateState>(
              listener: (context,state)
              {
                if(state.isFailure)
                {
                  if(state.authException!=null) {
                    Scaffold.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                          SnackBar(
                            content: Row(

                              children: [
                                Wrap(children: [
                                  TextViewBuilder(
                                      state.authException.message??"",
                                      colorfont: ColorsApp.white,
                                      fontWeight: FontWeight.w400,
                                      textSize: 15),
                                ],)
                              ],
                            ),
                            backgroundColor: Colors.red,
                          )
                      );
                  }

                }
                if(state.isSubmitting)
                {
                  if(state.authException!=null)
                  {
                    Scaffold.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextViewBuilder(Strings.CARGANDO,colorfont: ColorsApp.white,fontWeight: FontWeight.w400,textSize: 15),
                                CircularProgressIndicator(backgroundColor: ColorsApp.blue,)
                              ],
                            ),
                            backgroundColor: ColorsApp.blue,
                          )
                      );
                  }
                }
                if(state.isSuccess)
                {
                  if(state.authException!=null)
                  {
                    FToast fToast = FToast(context);
                    fToast.showToast(
                        child: ToastCustomized(state.authException.message),
                        gravity: ToastGravity.BOTTOM,
                        toastDuration: Duration(seconds: 2));
                  }
                }
              },
              child: BlocBuilder<UpdateBloc,UpdateState>(
                  builder: (context,state)
                  {
                   return  Scaffold(
                        backgroundColor: Colors.transparent,
                        body: FadeAnimation(1.5,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(height: 30.0,),
                              Expanded(
                                  flex: 1,
                                  child: headerHome()
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
                                    child: StreamBuilder<Alumno>(
                                      stream: _updateBloc.alumno(),

                                      builder: (context, snapshot)
                                      {
                                        print("Datosss $snapshot");
                                        if(snapshot.hasData)
                                        {
                                          alumno = snapshot.data;
                                          return Container(
                                            padding: EdgeInsets.all(5),
                                            child: ListViewBuilderMaterias(materias: alumno.materias,),
                                          );
                                        }
                                        return Center(child: CircularProgressIndicator(),);
                                      }
                                    ),
                                    ),
                                  ),
                                ),

                            ],
                          ),
                        ),
                        floatingActionButton: floatingButton()
                    );
                  }
              )
            );

  }

  @override
  void onMessage(String message) {
    // TODO: implement onMessage
    setState(() {
      print(" resultado");
      messages = message;
    });
  }

  void setSnackBar(String message) {
    if (message != "") {
      setState(() {
        messages = "";
      });
    }
  }






  Widget headerHome() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, right: MediaQuery
                .of(context)
                .size
                .width / 4),
            child: TextViewBuilder(
                widget.title, colorfont: ColorsApp.white,
                textSize: 30.0),),
          IconButton(
            icon: Icon(
              Icons.settings, color: ColorsApp.blue,
              size: 30.0,),
            onPressed: () async
            {
              showModalBottomSheet(

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0))),
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 30.0),
                        child: ButtonSheetInit(studentRepository: widget
                            .studentRepository,) // BottonSheet(alumno: alumno,notificarObject: this),
                    );
                  });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.exit_to_app, color: ColorsApp.blue,
              size: 30.0,),
            onPressed: () async
            {
              BlocProvider.of<AuthBloc>(context).add(LoggedOut());
            },
          ),
        ],
      ),
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
              Strings.INSCRIPCION_CLASE, colorfont: ColorsApp.black_1,
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
                  key: _keyaddmateria,
                  decoration: Decorations().decorationtext(
                      hintText: Strings.CODIGO_CLASE,
                      colorBorder: ColorsApp.white,
                      colorBorderFocused: ColorsApp.white),
                  validator: (String val) {
                    return val != null
                        ? Strings.ERRORCODIGOCLASE
                        : null;
                  },
                  onChanged: (String code) {
                    codeMateria = code;
                  },
                ),
              ]
          ),
          actions: <Widget>[
            RaisedButton(
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
            RaisedButton(
              child: TextViewBuilder(
                  Strings.INSCRIBIRSE, colorfont: ColorsApp.white,
                  textSize: 14.0,
                  fontWeight: FontWeight.w400),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              onPressed: () =>
              {
                if(!SearchHelper().evaluarCodigo(codeMateria, alumno.materias))
                  {

                    _updateBloc.add(AddOrUpdateSubjects(
                        materia: codeMateria,
                        materias: alumno.materias)),
                    Navigator.of(context).pop()
                  }
                else
                  {
                    Navigator.of(context).pop(),
                    setState(() {
                      messages = "ya tienes registrada esa materia";
                    })
                  }
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
      child: Icon(Icons.add, color: ColorsApp.white,),
    );
  }

}
