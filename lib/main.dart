import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practilab/bloc/auth_bloc/auth_bloc.dart';
import 'package:practilab/repository/StudentRepository.dart';
import 'package:practilab/repository/UserRepository.dart';
import 'package:practilab/res/values/Colors.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/screens/autenticacion/Login.dart';
import 'package:practilab/screens/autenticacion/SignUp.dart';
import 'package:practilab/screens/home/materias_views/Principal.dart';
import 'package:transparent_image/transparent_image.dart';

import 'bloc/auth_bloc/Simple_Bloc_Delegate.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();// es requerida desde la version 1.9.4 en adelante
  await Firebase.initializeApp();
  SimpleDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
      BlocProvider(
        create: (context)=>AuthBloc(userRepository:  userRepository)
          ..add(AppStarted()),
        child: MyApp(userRepository: userRepository),
      )
  );
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;
  MyApp({Key key,@required UserRepository userRepository})
      : assert(userRepository!=null), _userRepository= userRepository,super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

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
            fadeInDuration:  Duration(milliseconds: 500),
            placeholder: kTransparentImage,//DrawableValues.BACKGROUND_IMAGE,
            image: "https://firebasestorage.googleapis.com/v0/b/practilab-itsu.appspot.com/o/background.png?alt=media&token=20ac8e79-6e87-459f-982f-0eb902e5d83d",
            ),
            BlocBuilder<AuthBloc,AuthState>(
              builder: (context,state)
              {
                /*if(state is Uninitialized)
                {
                  return SplashScreen();
                }*/
                if(state is Authenticated)
                {
                  return HomeScreen(title:  Strings.TUS_CLASES,user: state.users,studentRepository: StudentRepository(userId: state.users.uid),);
                }
                if(state is Unauthenticated || state is Uninitialized)
                {
                  return LoginScreen(title:Strings.LOGIN,userRepository: _userRepository,);
                }
                if(state is Authenticate)
                {
                  return SignUpScreen(title: Strings.SIGNUP,userRepository: _userRepository);
                }
                return Container();
              },
            )
          ]
      )
    );

  }
}


