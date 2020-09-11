import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:practilab/repository/UserRepository.dart';
import 'package:practilab/utilities/models/Users.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  UserRepository _userRepository;
  AuthBloc({@required UserRepository userRepository}) : super(Uninitialized())
  {
    _userRepository=userRepository;
  }
  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if(event is AppStarted)
    {
      yield* _mapAppStartedToState();
    }
    if(event is LoggedIn)
    {
      yield* _mapLoggedInToState();
    }
    if(event is LoggedOut)
    {
      yield* _mapLoggedOutToState();
    }
    if(event is SigningUp)
    {
      yield  Authenticate();
    }
    if(event is LogIn)
    {
      yield Unauthenticated();
    }
  }
  Stream<AuthState>_mapAppStartedToState() async*
  {
    try
    {
      final isSignedIn = await _userRepository.isSignedIn();
      if(isSignedIn)
      {
        final myUser = await _userRepository.getUser();
        yield Authenticated(users: myUser);
      }
      else {
        yield Unauthenticated();
      }
    }
    catch(_)
    {
      yield Unauthenticated();
    }
  }
  Stream<AuthState>_mapLoggedInToState() async*
  {
    try
    {
      final myUser = await _userRepository.getUser();

      yield Authenticated(users: myUser);

    }
    catch(_)
    {
      yield Unauthenticated();
    }
  }
  Stream<AuthState>_mapLoggedOutToState() async*
  {
    try
    {
      await _userRepository.signOut();
      yield Unauthenticated();

    }
    catch(_)
    {
      yield Unauthenticated();
    }
  }
}
