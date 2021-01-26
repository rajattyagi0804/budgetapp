import 'package:budgetapp/custom_widgets/Transactionwidget.dart';
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
    // TODO: implement initState
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
                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                      child: transactionCard(
                          snapshot.docs[index].get("description"),
                          snapshot.docs[index].get("money"),
                          snapshot.docs[index].get("moneytype"),
                          snapshot.docs[index].get("date")));
                },
                childCount: snapshot.docs.length,
              ))
            : SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()))
      ],
    );
  }
}
