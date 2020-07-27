import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'package:practilab/utilities/interfaces/Message.dart';
import 'package:practilab/utilities/models/User.dart';

class AuthService
{
  Message message;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //stream
  Stream<User> get user
  {
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }
  //get user
  User _userFromFirebaseUser(FirebaseUser user)
  {
    return user!=null?User(uid: user.uid):null;
  }
  //sign in with email & password
  Future signInUserEmailAndPassword(String email, String password) async
  {
    try{
      AuthResult  authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);

      return _userFromFirebaseUser(authResult.user);
    }
    on PlatformException catch (exception) {
      switch (exception.code) {
        case 'ERROR_USER_NOT_FOUND':
          message.onMessage("El email no está registrado");
          break;
        default:
          break;
      }
    }
    return null;
  }
  //register with email & password
  Future registerUserEmailAndPassword(String email, String password) async
  {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return _userFromFirebaseUser(authResult.user);
    } on PlatformException catch (exception) {
      switch (exception.code) {
        case 'ERROR_EMAIL_ALREADY_IN_USE':
         message.onMessage("El email ya existe");
          break;
        default:
          break;
      }
      return null;
    }
  }
  //sign out
  Future singOut() async
  {
    try {
      message.onMessage("Saliendo...");
      return await _auth.signOut();
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  //listenerMessage
  void setMessageListener(Message message)
  {
    this.message=message;
  }

}

