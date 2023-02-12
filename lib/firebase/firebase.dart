import 'package:cloud_firestore/cloud_firestore.dart';

void insertdata() {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference collectionReference =
      firebaseFirestore.collection("student");

  collectionReference
      .add({"id": "id", "name": "ronak", "mobile": "123546"})
      .then((value) => print("success"))
      .catchError((error) => print("${error}"));
}


Stream<QuerySnapshot<Map<String, dynamic>>> readdata()
{
  FirebaseFirestore firebaseFirestore =FirebaseFirestore.instance;
  return firebaseFirestore.collection("student").snapshots();
}

void deleteData(String key){
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  firebaseFirestore.collection("student").doc("$key").delete();
}


void updateData(String key,String id, String name, String mobile, String std){
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  firebaseFirestore.collection("student").doc("$key").set({"id": "$id", "name": "$name", "mobile": "$mobile", "std": "$std",});
}