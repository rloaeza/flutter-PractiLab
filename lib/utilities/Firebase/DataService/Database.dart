

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practilab/res/values/Strings.dart';
import 'package:practilab/utilities/interfaces/Message.dart';
import 'package:practilab/utilities/models/User.dart';

class DatabaseUser
{
  Message message;
  final String uid;

  DatabaseUser({this.uid,this.message});


  final CollectionReference alumnoCollection = Firestore.instance.collection("alumnos");

  //Create Alumno
  Future createUserData(String nombre,String apellidos,String email,String password,String telefono,String numeroCtrol) async
  {
    List<String> lista =[];
    return await alumnoCollection.document(uid).setData({
      "nombre":nombre,
      "apellidos":apellidos,
      "email":email,
      "password":password,
      "telefono":telefono,
      "numeroCtrol":numeroCtrol,
      "misclases":lista
    });
  }
  //actualizar materia
  Future updateUserData(String nombre,String apellidos,String telefono,String numeroCtrol) async
  {

    Future update = alumnoCollection.document(uid).updateData({
      "nombre":nombre,
      "apellidos":apellidos,
      "telefono":telefono,
      "numeroCtrol":numeroCtrol,
    });
    message.onMessage(Strings.ACTUALIZADOS);
    return update;


  }
  //actualizar lista de materias
  Future updateMateria(String materia,List<String>materias)
  {
    DocumentReference documentReference = alumnoCollection.document(uid);
    materias.add(materia);
    documentReference.updateData({"misclases":materias});
    message.onMessage(Strings.AGREGADAMATERIA);
  }
  //eliminar materia
  Future deleteMateria(String materia,List<String>materias)
  {
    DocumentReference documentReference = alumnoCollection.document(uid);
    materias.remove(materia);
    documentReference.updateData({"misclases":materias});
    message.onMessage(Strings.ELIMINADAMATERIA);
  }

  //get alumno stream
  Stream<Alumno> get alumno
  {
    Stream<Alumno> stream = alumnoCollection.document(uid).snapshots().map(( snapshot) => _alumnoFromSnapshot(snapshot));
    return stream;
  }

  //Alumno from snapshot
  Alumno _alumnoFromSnapshot(DocumentSnapshot doc)
  {
    Alumno student = Alumno(
          uid: uid,
          nombre: doc.data["nombre"],
          apellido: doc.data["apellidos"],
          email: doc.data["email"],
          password: doc.data["password"],
          telefono: doc.data["telefono"],
          numeroCtrol: doc.data["numeroCtrol"],
          materias: doc.data["misclases"].cast<String>()
      );
    return student;

  }
  //listenerMessage
  void setMessageListener(Message message)
  {
    this.message=message;
  }

}