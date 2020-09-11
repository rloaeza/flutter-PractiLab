part of 'login_bloc.dart';

@immutable
abstract class LoginEvent  extends Equatable{}

//EmailChanged
class EmailChanged extends LoginEvent
{
  final String email;
  EmailChanged({@required this.email});

  @override
  // TODO: implement props
  List<Object> get props => [email];
  @override
  String toString() {
    // TODO: implement toString
    return "EmailChanged{email: $email}";
  }
}
//PasswordChanged
class PasswordChanged extends LoginEvent
{
  final String password;
  final int charCant;
  PasswordChanged({@required this.password,@required this.charCant});

  @override
  // TODO: implement props
  List<Object> get props => [password];
  @override
  String toString() {
    // TODO: implement toString
    return "PasswordChanged{email: $password}";
  }
}
//Submitting
/*class Submitting extends LoginEvent
{
  final String email;
  final String password;
  Submitting({@required this.email,@required this.password});

  @override
  // TODO: implement props
  List<Object> get props => [email,password];
  @override
  String toString() {
    // TODO: implement toString
    return "Submitting {email: $email, password : $password}";
  }
}*/
//LoginWithCredentials
class LoginWithCredentials extends LoginEvent
{
  final String email;
  final String password;
  LoginWithCredentials({@required this.email,@required this.password});

  @override
  // TODO: implement props
  List<Object> get props => [email,password];
  @override
  String toString() {
    // TODO: implement toString
    return "LoginWithCredentials {email: $email, password : $password}";
  }
}
