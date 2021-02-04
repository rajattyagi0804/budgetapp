import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreFunction {
  getUserInformation(String uid) async {
    return await FirebaseFirestore.instance
        .collection("user")
        .doc(uid)
        .collection("entrydata")
        .orderBy("time", descending: true)
        .get();
  }

  getRemainders(String uid) async {
    return await FirebaseFirestore.instance
        .collection("user")
        .doc(uid)
        .collection("remainder")
        .orderBy("date", descending: false)
        .get();
  }

  deleteTransaction(String id, String uid) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(uid)
        .collection("entrydata")
        .doc(id)
        .delete();
  }

  deleteRemainder(String id, String uid) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(uid)
        .collection("remainder")
        .doc(id)
        .delete();
  }
}
