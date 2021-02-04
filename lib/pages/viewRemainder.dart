import 'package:budgetapp/common/color_constants.dart';
import 'package:budgetapp/custom_widgets/Transactionwidget.dart';
import 'package:budgetapp/pages/addRemainder.dart';
import 'package:budgetapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewRemainder extends StatefulWidget {
  @override
  _ViewRemainderState createState() => _ViewRemainderState();
}

class _ViewRemainderState extends State<ViewRemainder> {
  FirebaseAuth auth = FirebaseAuth.instance;
  QuerySnapshot snapshot;
  FirestoreFunction firestoreFunction = FirestoreFunction();
  User user;
  var uid;
  getRemainders() async {
    user = auth.currentUser;
    uid = user.uid;
    QuerySnapshot k = await firestoreFunction.getRemainders(uid);
    setState(() {
      snapshot = k;
    });
  }

  @override
  void initState() {
    super.initState();
    getRemainders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Remainders",
          style: GoogleFonts.spartan(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: ColorConstants.kwhiteColor,
          ),
        ),
      ),
      body: Container(
          color: Colors.black,
          child: snapshot != null
              ? ListView.builder(
                  itemCount: snapshot.docs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onDoubleTap: () {
                        dialogue(snapshot.docs[index].reference.id);
                      },
                      child: remainderCard(
                        snapshot.docs[index].get("title"),
                        snapshot.docs[index].get("money"),
                        snapshot.docs[index].get("date"),
                      ),
                    );
                  },
                )
              : Container(
                  color: Colors.black,
                )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: navigateToAddRemainder,
      ),
    );
  }

  navigateToAddRemainder() async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddRemainder();
    }));
    if (result == true) {
      getRemainders();
    }
  }

  dialogue(id) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Delete"),
              onPressed: () {
                firestoreFunction.deleteRemainder(id, uid);
                getRemainders();
                Navigator.of(context).pop(true);
              },
            ),
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
