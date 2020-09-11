import 'dart:async';
import 'dart:html';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practilab/utilities/models/Materia.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
