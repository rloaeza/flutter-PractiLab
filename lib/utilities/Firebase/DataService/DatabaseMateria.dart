
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practilab/utilities/models/Materia.dart';

class DatabaseMateria
{
  final String uid;
  final List<dynamic> mismaterias;
  DatabaseMateria({this.uid, this.mismaterias});
  final CollectionReference materiaCollection = Firestore.instance.collection("Materia");
  //get materia from snapshot
  Materia _materiaDataFromSnapshot(DocumentSnapshot snapshot)
  {
    if(snapshot!=null)
    {
      String nombre = snapshot.data["nombre"];
      List<dynamic> practicas = snapshot.data["practicas"];
      return Materia(
          nombre: nombre,
          cantidadPracticas: practicas.length,
          practicas: practicas
      );
    }
    return null;
  }
  //get materia doc stream
  Stream<Materia> get materiaData
  {
    return materiaCollection.document(uid).snapshots().map((event) =>_materiaDataFromSnapshot(event));
  }

  //materias list from snapshot
  List<Materia> _materiaListFromSnapshot(QuerySnapshot snapshot)
  {
    List<Materia> materias=[];
    List<DocumentSnapshot> documents = snapshot.documents;
    int j=0;
    int i=0;
    do
    {
       if(documents[i].documentID==mismaterias[j].toString())
       {
         print(documents[i].documentID);
         List<dynamic> practicas = documents[i].data["practicas"];
         materias.add(  Materia(
             uid:  documents[i].documentID,
             nombre: documents[i].data["nombre"],
             practicas: practicas.cast<String>(),
             cantidadPracticas: practicas.length
         ));
         i=0;
         j++;
       }
       else
       {
         i++;
       }
    }while(i<documents.length && j<mismaterias.length);

    return materias;
  }

  //get materias stream
  Stream <List<Materia>> get materias
  {
    Stream <List<Materia>> stream =  materiaCollection.snapshots().map(_materiaListFromSnapshot);
    print(stream);
    return stream;
  }

}