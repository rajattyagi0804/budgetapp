import 'package:budgetapp/common/color_constants.dart';
import 'package:budgetapp/custom_widgets/Transactionwidget.dart';
import 'package:budgetapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
          "Notification",
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
                    Timestamp temp = snapshot.docs[index].get("date");
                    if (DateTime.now().isAfter(temp.toDate())) {
                      return GestureDetector(
                        onPanUpdate: (details) {
                          if (details.delta.dx < 0) {
                            firestoreFunction.deleteRemainder(
                                snapshot.docs[index].reference.id, uid);
                            getRemainders();
                          }
                        },
                        child: notificationCard(
                          snapshot.docs[index].get("title"),
                          snapshot.docs[index].get("money"),
                          snapshot.docs[index].get("date"),
                        ),
                      );
                    }
                  })
              : Container(
                  color: Colors.black,
                )),
    );
  }
}
