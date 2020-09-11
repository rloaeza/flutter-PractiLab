import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practilab/bloc/auth_bloc/update_data_bloc/update_bloc.dart';
import 'package:practilab/repository/StudentRepository.dart';
import 'package:practilab/res/values/Animation.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/utilities/componentes/ButtonPressedRaised.dart';
import 'package:practilab/utilities/componentes/Decorations.dart';
import 'package:practilab/utilities/componentes/Loading.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:practilab/utilities/interfaces/NotificarEliminacion.dart';
import 'package:practilab/utilities/models/Alumno.dart';
import 'Toast.dart';


class ButtonSheetInit extends StatelessWidget {

  final StudentRepository studentRepository;
  ButtonSheetInit({Key key,@required this.studentRepository}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocProvider<UpdateBloc>(
        create: (context)=>UpdateBloc(studentRepository: studentRepository),
        child: BottonSheet(studentRepository: studentRepository),
      ),

    );
  }
}


class BottonSheet extends StatefulWidget
{
  NotificarObject notificarObject;
  final StudentRepository studentRepository;
  BottonSheet({@required this.studentRepository});
  @override
  _BottonSheetState createState() => new _BottonSheetState();

 }
class _BottonSheetState extends State<BottonSheet> {
  Alumno alumno;
  UpdateBloc _updateBloc;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _numCtrlController = TextEditingController();
  //funcion que indica si en los edit text de name,last_name,phone y numCtrl no estan vacios
  bool get isPopulated => _nameController.text.isNotEmpty && _lastNameController.text.isNotEmpty && _phoneController.text.isNotEmpty && _numCtrlController.text.isNotEmpty;
  //indica si el button está habilidado si  el estado del form es valido y si los parametros estan ocupados
  bool isLoginButtonEnabled(UpdateState state)
  {
    return state.isFormValid && isPopulated && !state.isSubmitting ;
  }
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _updateBloc = BlocProvider.of<UpdateBloc>(context);
    _nameController.addListener(_onNameChanged);
    _lastNameController.addListener(_onLastNameChanged);
    _phoneController.addListener(_onPhoneChanged);
    _numCtrlController.addListener(_onNumberControlChanged);


  } @override
  void dispose() {
    // TODO: implement dispose

    _updateBloc.close();
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _numCtrlController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context)
  {
     return StreamBuilder<Alumno>(
       stream: _updateBloc.alumno(),
       builder: (context, snapshot)
       {
         setData(snapshot.data);
         return !snapshot.hasData?Loading():
         BlocListener<UpdateBloc,UpdateState>(
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
                             TextViewBuilder(Strings.ACTUALIZANDO,colorfont: ColorsApp.white,fontWeight: FontWeight.w400,textSize: 15),
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
                 Navigator.of(context).pop();
               }
             }
           },
           child: BlocBuilder<UpdateBloc,UpdateState>(
            builder: (context,state)
            {

              return Form(
                child: ListView(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  children: <Widget>
                  [
                    TextViewBuilder(
                      Strings.ACTUALIZADATOS, colorfont: ColorsApp.blue,),
                    SizedBox(height: 20.0,),
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

                                controller: _nameController,
                                autovalidate: true,
                                autocorrect: true,
                                textCapitalization: TextCapitalization.words,
                                decoration: Decorations().decorationtext(hintText: Strings.NAME,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                validator: (String name)
                                {
                                  return !state.isNameValid?Strings.ERROREMPTY:null;
                                },
                              ),
                            ]
                        )
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10),),
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
                                controller: _lastNameController,
                                autovalidate: true,
                                autocorrect: true,
                                textCapitalization: TextCapitalization.words,
                                decoration: Decorations().decorationtext(hintText: Strings.LASTNAME,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                validator: (String val)
                                {
                                  return !state.isLastNameValid?Strings.ERROREMPTY:null;
                                },
                              ),
                            ]
                        )
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10),),
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

                                controller: _numCtrlController,
                                autovalidate: true,
                                autocorrect: true,
                                keyboardType: TextInputType.number,
                                decoration: Decorations().decorationtext(hintText: Strings.CTRL_NUMBER,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                validator: (String val)
                                {
                                  return !state.isNumCtrolValid?Strings.ERRORNUMCTRL:null;
                                },
                                maxLength: 8,
                              ),
                            ]
                        )
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10),),
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
                                controller: _phoneController,
                                autovalidate: true,
                                autocorrect: true,
                                keyboardType: TextInputType.number,
                                decoration: Decorations().decorationtext(hintText: Strings.PHONE,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                validator: (String val)
                                {
                                  return !state.isPhoneValid?Strings.ERRORPHONE:null;
                                },
                                maxLength: 10,
                              ),
                            ]
                        )
                    ),
                    SizedBox(height: 30.0,),
                    ButtonPressedRaised(title:Strings.ACTUALIZAR,onPressed: isLoginButtonEnabled(state)?_onFormSubmitted:null),
                  ],
                ),
              );
            },
           ),
         );
       }
     );
  }

  void _onNameChanged()
  {
     print("name: ${_nameController.text}");
    _updateBloc.add(NameChanged(name: _nameController.text));
  }
  void _onLastNameChanged()
  {
    _updateBloc.add(LastNameChanged(lastname: _lastNameController.text));
  }

  void _onPhoneChanged()
  {
    _updateBloc.add(PhoneChanged(phone: _phoneController.text,charCant: 10));
  }
  void _onNumberControlChanged()
  {
    _updateBloc.add(NumCtrlChanged(numctrl: _numCtrlController.text,charCant: 8));
  }
  void _onFormSubmitted()
  {
    _updateBloc.add(UpdateDataStudent(name: _nameController.text,lastName: _lastNameController.text,phone: _phoneController.text,numCtrl: _numCtrlController.text));
  }
  void setData(Alumno alumno)
  {
    if(alumno!=null && _nameController.text.isEmpty && _lastNameController.text.isEmpty && _numCtrlController.text.isEmpty && _phoneController.text.isEmpty)
    {
        this.alumno = alumno;
        _nameController.text = alumno.nombre;
        _lastNameController.text = alumno.apellido;
        _phoneController.text = alumno.telefono;
        _numCtrlController.text = alumno.numeroCtrol;
    }
  }


}