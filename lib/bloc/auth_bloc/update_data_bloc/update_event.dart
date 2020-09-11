part of 'update_bloc.dart';

@immutable
abstract class UpdateEvent  extends Equatable {
  const UpdateEvent();
}
//Namechanged
class NameChanged extends UpdateEvent
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
class LastNameChanged extends UpdateEvent
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
class PhoneChanged extends UpdateEvent
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
class NumCtrlChanged extends UpdateEvent
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
class UpdateDataStudent extends UpdateEvent
{

  final String name;
  final String lastName;
  final String numCtrl;
  final String phone;
  UpdateDataStudent({@required this.name,@required this.lastName,@required this.phone,@required this.numCtrl});

  @override
  // TODO: implement props
  List<Object> get props => [name,lastName,phone,numCtrl];
}
//add or update lista materias
class AddOrUpdateSubjects extends UpdateEvent
{
  final String materia;
  final List<String>materias;
  AddOrUpdateSubjects({this.materia,this.materias});
  @override
  // TODO: implement props
  List<Object> get props => [materia,materias];

}
//eliminar materia
class DeleteSubjects extends UpdateEvent
{
  final String materia;
  final List<String>materias;
  DeleteSubjects({this.materia,this.materias});
  @override
  // TODO: implement props
  List<Object> get props => [materia,materias];

}