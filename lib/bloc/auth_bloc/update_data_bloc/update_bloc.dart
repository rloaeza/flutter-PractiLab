import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:practilab/repository/MateriaRepository.dart';
import 'package:practilab/utilities/models/Alumno.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:practilab/repository/StudentRepository.dart';
import 'package:practilab/utilities/exception/AuthException.dart';
import 'package:practilab/utilities/mixin/ValidationFieldsMixin.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState>  with ValidationFieldsMixin{
  StudentRepository _studentRepository;

  UpdateBloc({@required StudentRepository studentRepository}) : super(UpdateState.initial()){
    this._studentRepository = studentRepository;
  }
  @override
  Stream<Transition<UpdateEvent, UpdateState>> transformEvents(Stream<UpdateEvent> events, transitionFn) {
    // TODO: implement transformEvents
    final nonDebounceStream = events.where((event) {
      return (event is! NameChanged && event is! LastNameChanged && event is! PhoneChanged && event is! NumCtrlChanged);
    });
    final debounceStream = events.where((event) {
      return (event is NameChanged || event is LastNameChanged || event is PhoneChanged || event is NumCtrlChanged);
    }).debounceTime(Duration(milliseconds: 200));

    return super.transformEvents( nonDebounceStream.mergeWith([debounceStream]), transitionFn);
  }
  @override
  Stream<UpdateState> mapEventToState(
    UpdateEvent event,
  ) async* {
    if(event is NameChanged)
    {
      print(event.name);
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
    if(event is AddOrUpdateSubjects)
    {
      bool exist = await MateriaRepository().searchMateria(event.materia);
      if(exist)
      {
          yield UpdateState.loading();
          await _studentRepository.updateMateria(event.materia, event.materias);
          yield UpdateState.success(authException: AuthException(message: "Materia agregada"));
      }
      else {
          yield UpdateState.failure(authException: AuthException(message: "La materia que buscas no existe."));
      }

    }
    if(event is DeleteSubjects)
    {
      yield UpdateState.loading();
      await _studentRepository.deleteMateria(event.materia, event.materias);
      yield UpdateState.success(authException: AuthException(message: "Materia eliminada"));

    }
    if(event is UpdateDataStudent)
    {
      yield* _mapUpdateStudentPressedToState(event.name,event.lastName,event.phone,event.numCtrl);
    }
  }
  Stream<UpdateState> _mapNameChangedToState(String name) async* {
    yield state.update(
      isNameValid: isFieldEmpty(name),
    );
  }
  Stream<UpdateState> _mapLastNameChangedToState(String lastName) async* {
    yield state.update(
      isLastNameValid:isFieldEmpty(lastName),
    );
  }
  Stream<UpdateState> _mapPhoneChangedToState(String phone,int cantChars) async* {
    yield state.update(
      isPhoneValid:isNumber(phone,cantChars),
    );
  }
  Stream<UpdateState> _mapNumCtrlChangedToState(String numctrl,int cantChars) async* {
    yield state.update(
      isNumCtrolValid:isNumber(numctrl,cantChars),
    );
  }
  Stream<UpdateState> _mapUpdateStudentPressedToState(String name, String lastName, String phone,String numCtrl) async*
  {
    try {
       yield UpdateState.loading();
       _studentRepository.updateUserData(name, lastName, phone, numCtrl);
        yield UpdateState.success(authException: AuthException(message: "Datos actualizados"));
    }  catch (e)
    {
      print(e.message);

      yield UpdateState.failure(authException: AuthException(message: "Error, al actualizar, verifica tu conexión"));
    }
  }
  Stream<Alumno> alumno()
  {
    Future.delayed(Duration(seconds: 5));
    return _studentRepository.alumno;
  }
}
