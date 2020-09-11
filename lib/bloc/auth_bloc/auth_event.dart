part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent  extends Equatable{

}
//Inicio
class AppStarted extends AuthEvent
{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
//Log-In
class LogIn extends AuthEvent
{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
//registrarse
class SigningUp extends AuthEvent
{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
//LoggedIn
class LoggedIn extends AuthEvent
{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
//LoggedOut
class LoggedOut extends AuthEvent
{
  @override
  // TODO: implement props
  List<Object> get props => [];
}