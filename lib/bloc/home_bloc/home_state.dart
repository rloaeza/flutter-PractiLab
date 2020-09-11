part of 'home_bloc.dart';

@immutable
class HomeState
{
  final bool isPhoneValid;
  final bool isNumCtrolValid;
  final bool isNameValid;
  final bool isLastNameValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isNameValid && isLastNameValid && isNumCtrolValid && isPhoneValid;

  HomeState({this.isPhoneValid, this.isNumCtrolValid, this.isNameValid,
      this.isLastNameValid, this.isSubmitting, this.isSuccess, this.isFailure});

  //factory cuando implementamos un constructor que no siempre crea una nueva instancia de su clase.
  factory HomeState.initial()
  {
    return HomeState(
        isNameValid: true,
        isLastNameValid: true,
        isPhoneValid: true,
        isNumCtrolValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
    );
  }
  //loadingMaterias
  //AddMateria
  //DeleteMateria
}

