part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}
//Namechanged
class NameChanged extends HomeEvent
{
  final String name;
  NameChanged({@required this.name});

  @override
  // TODO: implement props
  List<Object> get props => [name];
  @override
  String toString() {
    // TODO: implement toString
    return "NameChanged{name: $name}";
  }
}
//LastNameChanged
class LastNameChanged extends HomeEvent
{
  final String lastname;
  LastNameChanged({@required this.lastname});

  @override
  // TODO: implement props
  List<Object> get props => [lastname];
  @override
  String toString() {
    // TODO: implement toString
    return "LastNameChanged{name: $lastname}";
  }
}
//PhoneChanged
class PhoneChanged extends HomeEvent
{
  final String phone;
  final int charCant;
  PhoneChanged({@required this.phone,@required this.charCant});

  @override
  // TODO: implement props
  List<Object> get props => [phone];
  @override
  String toString() {
    // TODO: implement toString
    return "PhoneChanged{phone: $phone }";
  }
}
//NumCtrlChanged
class NumCtrlChanged extends HomeEvent
{
  final String numctrl;
  final int charCant;
  NumCtrlChanged({@required this.numctrl,@required this.charCant});

  @override
  // TODO: implement props
  List<Object> get props => [numctrl];
  @override
  String toString() {
    // TODO: implement toString
    return "NumCtrlChanged{numctrl: $numctrl}";
  }
}

//Update Alumno
class UpdateDataStudent extends HomeEvent
{
  final String userId;
  final String name;
  final String lastName;
  final String numCtrl;
  final String phone;
  UpdateDataStudent({@required this.userId,@required this.name,@required this.lastName,@required this.phone,@required this.numCtrl});

  @override
  // TODO: implement props
  List<Object> get props => [userId,name,lastName,phone,numCtrl];
}
//Add Materia
class UpdateSubjects extends HomeEvent
{
  final String subject;
  final List<String> subjects;
  UpdateSubjects({@required this.subject,@required this.subjects});
  @override
  // TODO: implement props
  List<Object> get props => [subject];
}
//Delete Materia
class DeleteSubjects extends HomeEvent
{
  final String subject;
  final List<String> subjects;
  DeleteSubjects({@required this.subject,@required this.subjects});
  @override
  // TODO: implement props
  List<Object> get props => [subject];
}
