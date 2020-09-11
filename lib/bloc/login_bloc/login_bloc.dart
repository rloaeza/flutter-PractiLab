import 'dart:async';
import 'package:meta/meta.dart';
import 'package:practilab/utilities/exception/AuthException.dart';
import 'package:practilab/utilities/mixin/ValidationFieldsMixin.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:practilab/repository/UserRepository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>  with ValidationFieldsMixin {

  UserRepository _repository;
  LoginBloc({@required UserRepository userRepository}) : super(LoginState.empty())
  {
    _repository=userRepository;
  }
  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(Stream<LoginEvent> events, transitionFn) {
    // TODO: implement transformEvents
    final nonDebounceStream = events.where((event) {
      return (events is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (events is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 200));

    return super.transformEvents( nonDebounceStream.mergeWith([debounceStream]), transitionFn);
  }
  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    }
    if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password,event.charCant);
    }
    if (event is LoginWithCredentials)
    {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }
  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password,int cantChars) async* {
    yield state.update(
      isPasswordValid: isValidPassword(password,cantChars),
    );
  }


  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      await _repository.signInWithCredentials(
        email: email,
        password: password,
      );
      yield LoginState.success();
    }  catch (e)
    {
      print(e.message);
      if(e.message == "There is no user record corresponding to this identifier. The user may have been deleted.")
      {
        yield LoginState.failure(authException: AuthException(message: "Credenciales inexistentes"));
      }
      else  if(e.message=="The user account has been disabled by an administrator."){
          yield LoginState.failure(authException: AuthException(message: "Cuenta deshabilitada"));
      }
      else  if(e.message=="The password is invalid or the user does not have a password."){
        yield LoginState.failure(authException: AuthException(message: "Contraseña incorrecta"));
      }
      else {
        yield LoginState.failure(authException: AuthException(message: "Verifique su conexión a Internet"));
      }

    }
  }
}
