import 'package:practilab/utilities/models/Practica.dart';

class DataPracticaRepository
{
  Practica _practica;
  static DataPracticaRepository _instance = DataPracticaRepository._internal();

  DataPracticaRepository._internal();

  factory DataPracticaRepository()
  {
    return _instance;
  }
  Practica get practica => _practica;

  set practica(Practica practica)
  {
    print("Nombre:"+practica.nombre);
    _practica = practica;

  }
}