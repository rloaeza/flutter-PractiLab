
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practilab/bloc/auth_bloc/auth_bloc.dart';
import 'package:practilab/bloc/register_bloc/register_bloc.dart';
import 'package:practilab/repository/UserRepository.dart';
import 'package:practilab/res/values/Animation.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/utilities/componentes/ButtonPressedRaised.dart';
import 'package:practilab/utilities/componentes/Decorations.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:practilab/utilities/componentes/Toast.dart';

class SignUpScreen extends StatelessWidget
{
  final String title;
  final UserRepository userRepository;
  SignUpScreen({Key key,this.title,@required this.userRepository}):super(key:key);
 @override
 Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.transparent,
    body: BlocProvider<RegisterBloc>(
      create: (context)=>RegisterBloc(userRepository: userRepository),
      child: SignUp(title: title,userRepository: userRepository),
    ),

 );
 }
}
class SignUp extends StatefulWidget {
  final String title;
  final UserRepository userRepository;
  SignUp({Key key,this.title,@required this.userRepository}):super(key:key);

  @override
  _SignUpState createState() => new _SignUpState();
 }

class _SignUpState extends State<SignUp>
{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _numCtrlController = TextEditingController();
  RegisterBloc _registerBloc;
  //funcion que indica si en los edit text de email, password,  password_confirm, name,last_name,phone y numCtrl no estan vacios
  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty && _passwordConfirmController.text.isNotEmpty
  && _nameController.text.isNotEmpty && _lastNameController.text.isNotEmpty && _phoneController.text.isNotEmpty && _numCtrlController.text.isNotEmpty;
  //indica si el button está habilidado si  el estado del form es valido y si los parametros estan ocupados
  bool isLoginButtonEnabled(RegisterState state)
  {
    return state.isFormValid && isPopulated && !state.isSubmitting ;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _passwordConfirmController.addListener(_onPasswordConfirmChanged);
    _nameController.addListener(_onNameChanged);
    _lastNameController.addListener(_onLastNameChanged);
    _phoneController.addListener(_onPhoneChanged);
    _numCtrlController.addListener(_onNumberControlChanged);
    BackButtonInterceptor.add(myInterceptor);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    BackButtonInterceptor.remove(myInterceptor);
    _registerBloc.close();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _numCtrlController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return BlocListener<RegisterBloc,RegisterState>(
     listener: (context,state)
     {
       if(state.isFailure)
       {
         if(state.authException!=null)
         {
           Scaffold.of(context)
             ..hideCurrentSnackBar()
             ..showSnackBar(
                 SnackBar(
                   content: Row(

                     children: [
                      Wrap(children: [
                        TextViewBuilder(state.authException.message ?? "",
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

         Scaffold.of(context)
           ..hideCurrentSnackBar()
           ..showSnackBar(
               SnackBar(
                 content: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     TextViewBuilder(Strings.INGRESANDO,colorfont: ColorsApp.white,fontWeight: FontWeight.w400,textSize: 15),
                     CircularProgressIndicator(backgroundColor: ColorsApp.blue, valueColor: new AlwaysStoppedAnimation<Color>(ColorsApp.yelow),)
                   ],
                 ),
                 backgroundColor: ColorsApp.blue,
               )
           );
       }
       if(state.isSuccess)
       {
         FToast fToast = FToast(context);
         fToast.showToast(
             child: ToastCustomized(Strings.REGISTROEXITOSO),
             gravity: ToastGravity.BOTTOM,
             toastDuration: Duration(seconds: 3));
           BlocProvider.of<AuthBloc>(context).add(SigningUp());
           myInterceptor(true,null);
       }
     },
     child: BlocBuilder<RegisterBloc,RegisterState>(
       builder: (context,state)
       {
         return FadeAnimation(2.0, Scaffold(
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
                       headerSignUp(),
                       Container(
                         padding: EdgeInsets.only(top: 80,),
                         child: Form(
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
                                         controller: _emailController,
                                         autovalidate: true,
                                         autocorrect: true,
                                         keyboardType: TextInputType.emailAddress,
                                         decoration: Decorations().decorationtext(hintText: Strings.EMAIL,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                         validator: (String emails)
                                         {
                                           return !state.isEmailValid?Strings.ERROREMAIL:null;
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
                                           controller: _passwordController,
                                           autovalidate: true,
                                           autocorrect: true,
                                           obscureText: true,
                                           decoration: Decorations().decorationtext(hintText: Strings.PASSOWORD,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                           validator: (String val)
                                           {
                                             return !state.isPasswordValid?Strings.ERRORPASSWORD:null;
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
                                           controller: _passwordConfirmController,
                                           autovalidate: true,
                                           autocorrect: true,
                                           obscureText: true,
                                           decoration: Decorations().decorationtext(hintText: Strings.PASSOWORDCONFIRM,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                           validator: (String val)
                                           {
                                             return !state.isPasswordConfirmValid?Strings.ERRORPASSWORD:null;
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
                                           controller: _nameController,
                                           autovalidate: true,
                                           autocorrect: true,
                                           textCapitalization: TextCapitalization.words,
                                           decoration: Decorations().decorationtext(hintText: Strings.NAME,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                           validator: (String val)
                                           {
                                             return !state.isNameValid?Strings.ERROREMPTY:null;
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
                               SizedBox(height: 5,),
                               Container(
                                 padding: EdgeInsets.only(bottom: 20.0),
                                 child: SizedBox(

                                   width: MediaQuery.of(context).size.width/2+100,
                                   height: 40,
                                   child: ButtonPressedRaised(title:Strings.SIGNUP,onPressed: isLoginButtonEnabled(state)?_onFormSubmitted:null)
                                   ,
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
         ),
         );
       },
     )
   );
  }
  void _onEmailChanged()
  {
    _registerBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged()
  {
    _registerBloc.add(PasswordChanged(password: _passwordController.text,charCant: 6));
  }
  void _onPasswordConfirmChanged()
  {
    _registerBloc.add(PasswordConfirmChanged(password: _passwordConfirmController.text,charCant: 6));
  }

  void _onNameChanged()
  {
    _registerBloc.add(NameChanged(name: _nameController.text));
  }
  void _onLastNameChanged()
  {
    _registerBloc.add(LastNameChanged(lastname: _lastNameController.text));
  }

  void _onPhoneChanged()
  {
    _registerBloc.add(PhoneChanged(phone: _phoneController.text,charCant: 10));
  }
  void _onNumberControlChanged()
  {
    _registerBloc.add(NumCtrlChanged(numctrl: _numCtrlController.text,charCant: 8));
  }

  void _onFormSubmitted()
  {
    if(_passwordConfirmController.text==_passwordController.text)
    {
      _registerBloc.add(RegisterWithCredentials(email: _emailController.text,password: _passwordController.text, numCtrl: _numCtrlController.text,
          lastName: _lastNameController.text ,name: _nameController.text ,phone: _phoneController.text));
    }
    else
    {
      _registerBloc.add(Failure(failure: "Password y su confirmación son diferentes"));
      _passwordConfirmController.text="";
      _passwordController.text="";

    }
   }

  bool myInterceptor(bool stopDefaultButtonEvent,RouteInfo info) {
    BlocProvider.of<AuthBloc>(context).add(LoggedIn());
    return true;
  }

  Widget headerSignUp()
  {
     return Row(
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
            myInterceptor(true,null);
            //BlocProvider.of<AuthBloc>(context).add(LogIn());
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
    );
  }
}



