part of 'register_bloc.dart';

@immutable
class RegisterState {

  final AuthException authException;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isPasswordConfirmValid;
  final bool isPhoneValid;
  final bool isNumCtrolValid;
  final bool isNameValid;
  final bool isLastNameValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;


  bool get isFormValid => isEmailValid && isPasswordValid && isPasswordConfirmValid && isNameValid && isLastNameValid && isNumCtrolValid && isPhoneValid;



  RegisterState(
      {@required this.isEmailValid, @required this.isPasswordValid, @required this.isPhoneValid, @required this.isNumCtrolValid, @required this.isNameValid,
       @required this.isLastNameValid,@required this.isPasswordConfirmValid, @required this.isSubmitting, @required this.isSuccess, @required this.isFailure,@required this.authException});

//factory cuando implementamos un constructor que no siempre crea una nueva instancia de su clase.

//relacionadas con el update
//empty
  factory RegisterState.empty()
  {
    return RegisterState(isEmailValid: true,
        isPasswordValid: true,
        isPasswordConfirmValid: true,
        isNameValid: true,
        isLastNameValid: true,
        isPhoneValid: true,
        isNumCtrolValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        authException: null);
  }

//loading
  factory RegisterState.loading()
  {
    return RegisterState(isEmailValid: true,
        isPasswordValid: true,
        isPasswordConfirmValid: true,
        isNameValid: true,
        isLastNameValid: true,
        isPhoneValid: true,
        isNumCtrolValid: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false,
        authException: null);
  }

//failure
  factory RegisterState.failure({AuthException authException})
  {
    return RegisterState(isEmailValid: true,
        isPasswordValid: true,
        isPasswordConfirmValid: true,
        isNameValid: true,
        isLastNameValid: true,
        isPhoneValid: true,
        isNumCtrolValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        authException: authException
    );
  }

//success
  factory RegisterState.success()
  {
    return RegisterState(isEmailValid: true,
        isPasswordValid: true,
        isPasswordConfirmValid: true,
        isNameValid: true,
        isLastNameValid: true,
        isPhoneValid: true,
        isNumCtrolValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        authException: null);
  }

//copywith
  RegisterState copyWith
      ({
    bool isEmailValid,
    bool isPasswordValid,
    bool isPasswordConfirmValid,
    bool isNameValid,
    bool isPhoneValid,
    bool isNumCtrolValid,
    bool isLastNameValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure
  }) {
    return RegisterState(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isPasswordConfirmValid: isPasswordConfirmValid ?? this.isPasswordConfirmValid,
        isNameValid: isNameValid ?? this.isNameValid,
        isLastNameValid: isLastNameValid ?? this.isLastNameValid,
        isPhoneValid: isPhoneValid ?? this.isPhoneValid,
        isNumCtrolValid: isNumCtrolValid ?? this.isNumCtrolValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure,
        authException: null);
  }

//update
  RegisterState update({
    bool isEmailValid,
    bool isPasswordValid,
    bool isPasswordConfirmValid,
    bool isNameValid,
    bool isPhoneValid,
    bool isNumCtrolValid,
    bool isLastNameValid
  }) {
    return copyWith(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        isPasswordConfirmValid: isPasswordConfirmValid,
        isNameValid: isNameValid,
        isLastNameValid: isLastNameValid,
        isPhoneValid: isPhoneValid,
        isNumCtrolValid: isNumCtrolValid
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return '''RegisterState
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
