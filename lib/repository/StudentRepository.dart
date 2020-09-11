
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practilab/utilities/models/Alumno.dart';

class StudentRepository
{
  //constructor
  final String userId;
  StudentRepository({this.userId});
  final CollectionReference alumnoCollection = FirebaseFirestore.instance.collection("alumnos");

  //Create Alumno
  Future<void> createUserData(String nombre,String apellidos,String email,String password,String telefono,String numeroCtrol) async
  {
    List<String> lista =[];
    return await alumnoCollection.doc(userId).set({
      "nombre":nombre,
      "apellidos":apellidos,
      "email":email,
      "password":password,
      "telefono":telefono,
      "numeroCtrol":numeroCtrol,
      "misclases":lista
    });
  }
  //actualizar Alumno
  Future updateUserData(String nombre,String apellidos,String telefono,String numeroCtrol) async
  {
    Future update = alumnoCollection.doc(userId).update({
      "nombre":nombre,
      "apellidos":apellidos,
      "telefono":telefono,
      "numeroCtrol":numeroCtrol,
    });

    return update;
  }
  //actualizar lista de materias, para agregar nueva materia a la lista personal
  Future updateMateria(String materia,List<String>materias)
  {
    DocumentReference documentReference = alumnoCollection.doc(userId);
    materias.add(materia);
    documentReference.update({"misclases":materias});
  }
  //eliminar materia de la lista personal
  Future deleteMateria(String materia,List<String>materias)
  {
    DocumentReference documentReference = alumnoCollection.doc(userId);
    materias.remove(materia);
    documentReference.update({"misclases":materias});

  }

  //get alumno de firebase
  Stream<Alumno> get alumno
  {
    Stream<Alumno> stream = alumnoCollection.doc(userId).snapshots().map(( snapshot) => _alumnoFromSnapshot(snapshot));
    return stream;
  }

  //Convertir alumno firebase a mi modelo Alumno
  Alumno _alumnoFromSnapshot(DocumentSnapshot doc)
  {
    Alumno student = Alumno(
        uid: userId,
        nombre: doc.data()["nombre"],
        apellido: doc.data()["apellidos"],
        email: doc.data()["email"],
        password: doc.data()["password"],
        telefono: doc.data()["telefono"],
        numeroCtrol: doc.data()["numeroCtrol"],
        materias: doc.data()["misclases"].cast<String>()
    );
    return student;

  }


}