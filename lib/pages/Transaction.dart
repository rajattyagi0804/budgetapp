import 'package:budgetapp/custom_widgets/Transactionwidget.dart';
import 'package:budgetapp/pages/transactionRecept.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../common/color_constants.dart';
import '../services/database.dart';

class Readddata extends StatefulWidget {
  @override
  _ReadddataState createState() => _ReadddataState();
}

class _ReadddataState extends State<Readddata> {
  bool isSigned = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid;

  QuerySnapshot snapshot;
  FirestoreFunction firestoreFunction = FirestoreFunction();
  getUser() async {
    User user = auth.currentUser;
    uid = user.uid;
    QuerySnapshot k = await firestoreFunction.getUserInformation(uid);
    setState(() {
      snapshot = k;
    });
  }

  @override
  void initState() {
    getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 50,
          ),
        ),
        SliverAppBar(
          backgroundColor: Colors.black,
          pinned: true,
          title: Text(
            "Recent Transactions",
            style: GoogleFonts.spartan(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: ColorConstants.kwhiteColor,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
        snapshot != null
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var a = snapshot.docs[index].get("description");
                  var b = snapshot.docs[index].get("money");
                  var c = snapshot.docs[index].get("moneytype");
                  var d = snapshot.docs[index].get("date");
                  var id = snapshot.docs[index].reference.id;
                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                      child: GestureDetector(
                          onLongPress: () async {
                            bool result = await dialogue(a, b, c, d, id);
                            setState(() {
                              getUser();
                            });
                          },
                          child: transactionCard(a, b, c, d)));
                },
                childCount: snapshot.docs.length,
              ))
            : SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()))
      ],
    );
  }

  dialogue(description, money, moneytype, date, id) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("View"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TransactionRecept(
                      description, money.toString(), moneytype, date);
                }));
              },
            ),
            FlatButton(
              child: Text("Delete"),
              onPressed: () {
                firestoreFunction.deleteTransaction(id, uid);
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
