import 'package:cloud_firestore/cloud_firestore.dart';

//collection reference
final CollectionReference taskCollection =
    FirebaseFirestore.instance.collection("task");

Future<void> updateUserData(
    String title, String details, String date, String time) async {
  await taskCollection.add({
    'title': title,
    'details': details,
    'date': date,
    'time': time,
  });
}

Future<void> deleteTask(DocumentSnapshot snapshot) async {
  await taskCollection.doc(snapshot.id).delete();
}
