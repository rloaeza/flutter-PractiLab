
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practilab/utilities/models/Practica.dart';
class PracticaRepository
{

  final List<String> mispracticas;
  PracticaRepository({ this.mispracticas});
  final CollectionReference practicaCollection = FirebaseFirestore.instance.collection("practica");



  //materias list from snapshot
  List<Practica> _materiaListFromSnapshot(QuerySnapshot snapshot)
  {
    List<Practica> practicas=[];
    List<DocumentSnapshot> documents = snapshot.docs;
    int j=0;
    int i=0;
    int con=0;
    do
    {
      if(documents[i].id==mispracticas[j].toString())
      {
        String uid = documents[i].id;
        String introduccion = documents[i].data()["introduccion"];
        List<String> cuestionarios = documents[i].data()["cuestionarios"].cast<String>();
        String procedimiento = documents[i].data()["procedimiento"];
        String status = documents[i].data()["status"];
        bool tipo = documents[i].data()["tipo"] as bool;
        print(documents[i].id);
        print("intro $introduccion");
        print("cuestio $cuestionarios");
        print("proced $procedimiento");
        print("tipo $tipo");
        print("status $status");
        practicas.add( Practica(
            uid:  uid,
            nombre: "Práctica ${j+1}",
            introduccion: introduccion,
            cuestionarios: cuestionarios,
            procedimiento: procedimiento,
            status: status,
            tipo: tipo
        ));
        i=0;
        j++;
      }
      else
      {
        i++;
      }
    }while(i<documents.length && j<mispracticas.length);

    return practicas;
  }

  //get materias stream
  Stream <List<Practica>> get practicas
  {
    Stream <List<Practica>> stream =  practicaCollection.snapshots().map(_materiaListFromSnapshot);
    print(stream);
    return stream;
  }

 }