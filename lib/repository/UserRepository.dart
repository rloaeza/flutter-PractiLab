import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practilab/repository/StudentRepository.dart';
import 'package:practilab/utilities/models/Users.dart';

class UserRepository
{
  ///Constructor
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ///SignIn
  Future<void>signInWithCredentials({@required String email,@required String password}) async
  {
    return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
  ///SignUp
  Future<bool>signUpWithCredentials({@required String email,@required String password,@required String name,@required String lastName,@required String phone,@required String numctrl}) async
  {
    print("$email $password");
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    if(userCredential!=null)
    {
       await  StudentRepository(userId: userCredential.user.uid).createUserData(name, lastName, email, password, phone, numctrl);
       await signInWithCredentials(email: email, password: password);
       return true;
    }
    return false;
  }
  ///SignOut
  Future<void>signOut() async
  {
    return await _firebaseAuth.signOut();
  }
  ///isLoggedIn
  Future<bool> isSignedIn()async
  {
    final currentUser = await _firebaseAuth.currentUser;
    return currentUser!=null;
  }
  ///User
  Future<Users> getUser() async
  {
    final user =  _firebaseAuth.currentUser;
    return  user == null?Users.empty:user.toUser;
  }
}

extension on User
{
  Users get toUser
  {
    return Users(uid: uid);
  }
}