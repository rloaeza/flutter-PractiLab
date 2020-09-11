part of 'update_bloc.dart';

@immutable
class UpdateState
{
  final AuthException authException;
  final bool isPhoneValid;
  final bool isNumCtrolValid;
  final bool isNameValid;
  final bool isLastNameValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isNameValid && isLastNameValid && isNumCtrolValid && isPhoneValid;

  UpdateState({this.isPhoneValid, this.isNumCtrolValid, this.isNameValid,
    this.isLastNameValid, this.isSubmitting, this.isSuccess, this.isFailure,final this.authException});

//factory cuando implementamos un constructor que no siempre crea una nueva instancia de su clase.


//relacionadas con el update
//Initial
  factory UpdateState.initial()
  {
    return UpdateState(
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
  factory UpdateState.loading()
  {
    return UpdateState(
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
  factory UpdateState.failure({AuthException authException})
  {
    return UpdateState(
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
  factory UpdateState.success({AuthException authException})
  {
    return UpdateState(
        isNameValid: true,
        isLastNameValid: true,
        isPhoneValid: true,
        isNumCtrolValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        authException: authException);
  }

//copywith
  UpdateState copyWith
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
    return UpdateState(
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
  UpdateState update({
    bool isNameValid,
    bool isPhoneValid,
    bool isNumCtrolValid,
    bool isLastNameValid
  }) {
    return copyWith(
        isNameValid: isNameValid,
        isLastNameValid: isLastNameValid,
        isPhoneValid: isPhoneValid,
        isNumCtrolValid: isNumCtrolValid
    );
  }

}
