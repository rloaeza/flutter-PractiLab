part of 'login_bloc.dart';

@immutable
class LoginState {
  final AuthException authException;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  bool get isFormValid => isEmailValid && isPasswordValid;
  LoginState({@required this.isEmailValid,@required this.isPasswordValid,@required this.isSubmitting,
    @required this.isSuccess,@required this.isFailure, this.authException});
  //factory cuando implementamos un constructor que no siempre crea una nueva instancia de su clase.
  //empty
  factory LoginState.empty()
  {
    return LoginState(isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false
    );
  }
  //loading
  factory LoginState.loading()
  {
    return LoginState(isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false);
  }
  //failure
  factory LoginState.failure({AuthException authException})
  {
    return LoginState(isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        authException: authException
    );
  }
  //success
  factory LoginState.success()
  {
    return LoginState(isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false);
  }
  //copywith
  LoginState copyWith
      ({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure
  })
  {
    return LoginState(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess, isFailure: isFailure ?? this.isFailure);
  }
  //update
  LoginState update({
    bool isEmailValid,
    bool isPasswordValid
  })
  {
    return copyWith(isEmailValid: isEmailValid, isPasswordValid:  isPasswordValid);
  }

  @override
  String toString() {
    // TODO: implement toString
    return '''LoginState
    {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure
    }
    ''';
  }

}

