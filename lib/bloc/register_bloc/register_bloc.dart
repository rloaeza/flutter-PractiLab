import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:practilab/repository/UserRepository.dart';
import 'package:practilab/utilities/exception/AuthException.dart';
import 'package:practilab/utilities/mixin/ValidationFieldsMixin.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> with ValidationFieldsMixin{

  UserRepository _repository;
  RegisterBloc({@required UserRepository userRepository}) : super(RegisterState.empty())
  {
    _repository=userRepository;
  }
  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(Stream<RegisterEvent> events, transitionFn) {
    // TODO: implement transformEvents
    final nonDebounceStream = events.where((event) {
      return (events is! EmailChanged && event is! PasswordChanged && event is! PasswordConfirmChanged
      && event is! NameChanged && event is! LastNameChanged && event is! PhoneChanged && event is! NumCtrlChanged);
    });
    final debounceStream = events.where((event) {
      return (events is EmailChanged || event is PasswordChanged || event is PasswordConfirmChanged
          || event is NameChanged || event is LastNameChanged || event is PhoneChanged || event is NumCtrlChanged);
    }).debounceTime(Duration(milliseconds: 200));

    return super.transformEvents( nonDebounceStream.mergeWith([debounceStream]), transitionFn);
  }
  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if(event is EmailChanged)
    {
      yield* _mapEmailChangedToState(event.email);
    }
    if(event is PasswordChanged)
    {
      yield* _mapPasswordChangedToState(event.password,event.charCant);
    }
    if(event is PasswordConfirmChanged)
    {
      yield* _mapPasswordConfirmChangedToState(event.password, event.charCant);
    }
    if(event is NameChanged)
    {
      yield* _mapNameChangedToState(event.name);
    }
    if(event is LastNameChanged)
    {
      yield* _mapLastNameChangedToState(event.lastname);
    }
    if(event is PhoneChanged)
    {
      yield* _mapPhoneChangedToState(event.phone, event.charCant);
    }
    if(event is NumCtrlChanged)
    {
      yield* _mapNumCtrlChangedToState(event.numctrl, event.charCant);
    }
    if(event is Failure)
    {

      yield* _mapFailureToState(event.failure);
    }
    if(event is RegisterWithCredentials)
    {
      yield* _mapRegisterWithCredentialsPressedToState(email: event.email,password: event.password,name: event.name,lastName: event.lastName,phone:  event.phone,numCtrl: event.numCtrl);
    }
  }
  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: isValidEmail(email),
    );
  }
  Stream<RegisterState> _mapPasswordChangedToState(String password,int cantChars) async* {
    yield state.update(
      isPasswordValid: isValidPassword(password,cantChars),
    );
  }
  Stream<RegisterState> _mapPasswordConfirmChangedToState(String password,int cantChars) async* {
    yield state.update(
      isPasswordConfirmValid: isValidPassword(password,cantChars),
    );
  }
  Stream<RegisterState> _mapNameChangedToState(String name) async* {
    yield state.update(
      isNameValid: isFieldEmpty(name),
    );
  }
  Stream<RegisterState> _mapLastNameChangedToState(String lastName) async* {
    yield state.update(
      isLastNameValid:isFieldEmpty(lastName),
    );
  }
  Stream<RegisterState> _mapPhoneChangedToState(String phone,int cantChars) async* {
    yield state.update(
      isPhoneValid:isNumber(phone,cantChars),
    );
  }
  Stream<RegisterState> _mapNumCtrlChangedToState(String numctrl,int cantChars) async* {
    yield state.update(
      isNumCtrolValid:isNumber(numctrl,cantChars),
    );
  }
  Stream<RegisterState> _mapFailureToState(String failure) async*
  {

    yield RegisterState.failure(authException: AuthException(message: failure));
  }
  Stream<RegisterState> _mapRegisterWithCredentialsPressedToState({
    String email,
    String password,
    String name,
    String lastName,
    String phone,
    String numCtrl
  }) async* {
    yield RegisterState.loading();
    try {
      bool result  = await _repository.signUpWithCredentials(
        email: email,
        password: password,
        name: name,
        lastName:lastName,
        phone: phone,
        numctrl: numCtrl
      );
      if(result)
      {
          yield RegisterState.success();
      }
      else
      {
        yield RegisterState.failure(authException: AuthException(message: "Error else"));
      }
    }
    catch (e)
    {
      print(e.message);
      if(e.message == "The email address is already in use by another account.")
      {
        yield RegisterState.failure(authException: AuthException(message: "El email ya está en uso por otra cuenta."));
      }
      else{
        yield RegisterState.failure(authException: AuthException(message: "Verifique su conexión a Internet"));

      }


    }
  }
}
