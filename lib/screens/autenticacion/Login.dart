
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practilab/bloc/auth_bloc/auth_bloc.dart';
import 'package:practilab/bloc/login_bloc/login_bloc.dart';
import 'package:practilab/repository/UserRepository.dart';
import 'package:practilab/res/values/Animation.dart';
import 'package:practilab/utilities/componentes/ButtonPressedRaised.dart';
import 'package:practilab/utilities/componentes/Decorations.dart';
import 'package:practilab/utilities/componentes/TextViewBuilder.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';


class LoginScreen extends StatelessWidget {
  final String title;
  final UserRepository userRepository;
  LoginScreen({Key key,@required this.title,@required this.userRepository}):super(key:key);
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.transparent,
     body: BlocProvider<LoginBloc>(
       create: (context)=>LoginBloc(userRepository: userRepository),
       child: Login(title:title,userRepository: userRepository),
     ),
   );
 }
}

class Login extends StatefulWidget
{
  final String title;
  final UserRepository userRepository;

  Login({Key key,@required this.title,@required this.userRepository}):super(key:key);

  @override
  State<StatefulWidget> createState()
  {
    // TODO: implement createState
    return _StateLogin();
  }

}

class _StateLogin  extends State<Login>
{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc;
  UserRepository get _userRepositiory => widget.userRepository;
  //funcion que indica si en los edit text de email y password no estan vacios
  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  //indica si el button está habilidado si  el estado del form es valido y si los parametros estan ocupados y no es submitted
  bool isLoginButtonEnabled(LoginState state)
  {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    // TODO: implement initState
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      BlocListener<LoginBloc,LoginState>(
          listener: (context,state)
          {
            if(state.isFailure)
            {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextViewBuilder(state.authException.message??"",colorfont: ColorsApp.white,fontWeight: FontWeight.w400),
                          Icon(Icons.error,color: Colors.white,)
                        ],
                      ),
                      backgroundColor: Colors.red,
                    )
                );
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
                          TextViewBuilder(Strings.INGRESANDO,colorfont: ColorsApp.white,fontWeight: FontWeight.w400),
                          CircularProgressIndicator(backgroundColor: ColorsApp.blue, valueColor: new AlwaysStoppedAnimation<Color>(ColorsApp.yelow),)
                        ],
                      ),
                      backgroundColor: ColorsApp.blue,
                    )
                );
            }
            if(state.isSuccess)
            {
              BlocProvider.of<AuthBloc>(context).add(LoggedIn());
            }
          },
          child: BlocBuilder<LoginBloc,LoginState>(
              builder: (context,state)
              {
               return FadeAnimation(2.0,Scaffold(
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
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 130),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent
                                  ),
                                  child: Form(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 70,
                                          width: MediaQuery.of(context).size.width/2+100,
                                          child:Stack(
                                            children: <Widget>[
                                              Material(
                                                  elevation: 5,
                                                  borderRadius: BorderRadius.circular(30),
                                                  child:Padding(padding: EdgeInsets.symmetric(vertical: 23,horizontal: 300),)
                                              ),
                                              TextFormField(
                                                controller: _emailController,
                                                keyboardType: TextInputType.emailAddress,
                                                decoration: Decorations().decorationtext(hintText: Strings.EMAIL,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                                autovalidate: true,
                                                autocorrect: true,
                                                validator: (String emails)
                                                {
                                                  print(state.isEmailValid);
                                                  return  !state.isEmailValid?Strings.ERROREMAIL:null;
                                                },
                                              ),
                                            ],
                                          ),
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
                                                    autocorrect: false,
                                                    obscureText: true,
                                                    decoration: Decorations().decorationtext(hintText: Strings.PASSOWORD,colorBorder: ColorsApp.white,colorBorderFocused: ColorsApp.white),
                                                    validator: (String val)
                                                    {
                                                      return  !state.isPasswordValid?Strings.ERRORPASSWORD:null;
                                                    },
                                                  ),
                                                ]
                                            )
                                        ),
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
                                          child:  ButtonPressedRaised(title:Strings.LOGIN,onPressed: isLoginButtonEnabled(state)?_onFormSubmitted:null),

                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context).size.width/2+100,
                                            height: 40,
                                            child:ButtonRegister(userRepository: _userRepositiory, title: Strings.SIGNUP)
                                        ),
                                      ],
                                    ),
                                  )
                              )
                            ]
                        ),
                      )
                  ),
                ),
                );
              }
        )
      );





  }

  void _onEmailChanged()
  {
    _loginBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged()
  {
    _loginBloc.add(PasswordChanged(password: _passwordController.text,charCant: 6));
  }
  void _onFormSubmitted()
  {
    _loginBloc.add(LoginWithCredentials(email: _emailController.text,password: _passwordController.text));
  }


}


class ButtonRegister extends StatelessWidget
{
  UserRepository userRepository;
  Color color;
  int elevation;
  String title;
  ButtonRegister({Key key,@required UserRepository userRepository, @required String title,int elevation=10,Color color = ColorsApp.blue}):super(key: key){
    this.userRepository=userRepository;
    this.title=title;
    this.color =color;
    this.elevation =elevation;
  }
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: ()
      {
        BlocProvider.of<AuthBloc>(context).add(SigningUp());
        /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return SignUp(title: Strings.SIGNUP,userRepository: userRepository); // HomePage(user: MyUser(id: "ghjhgbhjgbnjuhnjh"),);
      }));*/
      },
      elevation: this.elevation.toDouble(),
      color: this.color,
      child: TextViewBuilder(title,colorfont: ColorsApp.white,textSize: 20.0,fontWeight: FontWeight.w400),
    );
  }
}

