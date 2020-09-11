part of 'register_bloc.dart';



@immutable
abstract class RegisterEvent extends  Equatable{
  const RegisterEvent();
}
//EmailChanged
class EmailChanged extends RegisterEvent
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
class PasswordChanged extends RegisterEvent
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
    return "PasswordChanged{password: $password}";
  }
}
//PasswordConfirmChanged
class PasswordConfirmChanged extends RegisterEvent
{
  final String password;
  final int charCant;
  PasswordConfirmChanged({@required this.password,@required this.charCant});

  @override
  // TODO: implement props
  List<Object> get props => [password];
  @override
  String toString() {
    // TODO: implement toString
    return "PasswordChanged{password: $password}";
  }
}
//Namechanged
class NameChanged extends RegisterEvent
{
  final String name;
  NameChanged({@required this.name});

  @override
  // TODO: implement props
  List<Object> get props => [name];
  @override
  String toString() {
    // TODO: implement toString
    return "NameChanged{name: $name}";
  }
}
//LastNameChanged
class LastNameChanged extends RegisterEvent
{
  final String lastname;
  LastNameChanged({@required this.lastname});

  @override
  // TODO: implement props
  List<Object> get props => [lastname];
  @override
  String toString() {
    // TODO: implement toString
    return "LastNameChanged{name: $lastname}";
  }
}
//PhoneChanged
class PhoneChanged extends RegisterEvent
{
  final String phone;
  final int charCant;
  PhoneChanged({@required this.phone,@required this.charCant});

  @override
  // TODO: implement props
  List<Object> get props => [phone];
  @override
  String toString() {
    // TODO: implement toString
    return "PhoneChanged{phone: $phone }";
  }
}
//NumCtrlChanged
class NumCtrlChanged extends RegisterEvent
{
  final String numctrl;
  final int charCant;
  NumCtrlChanged({@required this.numctrl,@required this.charCant});

  @override
  // TODO: implement props
  List<Object> get props => [numctrl];
  @override
  String toString() {
    // TODO: implement toString
    return "NumCtrlChanged{numctrl: $numctrl}";
  }
}
class Failure extends RegisterEvent
{
  String failure;
  Failure({@required this.failure});

  @override
  // TODO: implement props
  List<Object> get props => [failure];

}

//RegisterWithCredentials
class RegisterWithCredentials extends RegisterEvent
{
  final String email;
  final String password;
  final String name;
  final String lastName;
  final String phone;
  final String numCtrl;
  RegisterWithCredentials({@required this.email,@required this.password,@required this.name,@required this.lastName,@required this.phone,@required this.numCtrl});

  @override
  // TODO: implement props
  List<Object> get props => [email,password];
  @override
  String toString() {
    // TODO: implement toString
    return "LoginWithCredentials {email: $email, password : $password}";
  }
}

