part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class Uninitialized extends AuthState {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    // TODO: implement toString
    return "No inicializado";
  }
}
class Authenticated extends AuthState
{
  final Users users;
  Authenticated({this.users});
  @override
  List<Object> get props => [];
  @override
  String toString() {
    // TODO: implement toString
    return "Autenticado user ${users.uid}";
  }
}
class Authenticate extends AuthState
{

  @override
  List<Object> get props => [];
  @override
  String toString() {
    // TODO: implement toString
    return "Autenticar  user";
  }
}

class Unauthenticated extends AuthState {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    // TODO: implement toString
    return "No Autenticado";
  }
}
