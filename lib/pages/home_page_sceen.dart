import 'package:budgetapp/common/color_constants.dart';
import 'package:budgetapp/pages/Transaction.dart';
import 'package:budgetapp/pages/about.dart';
import 'package:budgetapp/pages/contactPage.dart';
import 'package:budgetapp/pages/notification.dart';
import 'package:budgetapp/pages/pichartPage.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:budgetapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  var income = 0, expense = 0;

  FirebaseAuth auth = FirebaseAuth.instance;

  final numberFormat = new NumberFormat("##,###.00#", "en_US");
  Color color = ColorConstants.gblackColor;
  Color fcolor = ColorConstants.kgreyColor;
  bool isActive = false;

  bool _loading;
  int activeIndex;
  FirestoreFunction firestoreFunction = FirestoreFunction();
  User user;
  String id;
  getIncome() async {
    id = auth.currentUser.uid;
    QuerySnapshot k = await firestoreFunction.getUserInformation(id);
    if (k != null) {
      for (var i = 0; i < k.docs.length; i++) {
        if (k.docs[i].get("moneytype") == "Income") {
          income += k.docs[i].get("money");
        } else {
          expense += k.docs[i].get("money");
        }
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getIncome();

    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.kblackColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return NotificationPage();
                      }));
                    },
                    icon: Icon(Icons.notification_important_outlined),
                    color: ColorConstants.kwhiteColor,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 3.0, right: 3.0, bottom: 3.0, left: 25.0),
                      child: PopupMenuButton<String>(
                        child: Icon(
                          Icons.more_vert,
                          color: ColorConstants.kwhiteColor,
                        ),
                        onSelected: choiceAction,
                        itemBuilder: (BuildContext context) {
                          return Constants.choices.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Your Balance",
                style: GoogleFonts.spartan(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.kwhiteColor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\u20b9 ${income - expense}",
                      style: GoogleFonts.openSans(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.kwhiteColor,
                      ),
                    ),
                    Row(
                      children: [
                        income - expense == 0
                            ? Icon(
                                Icons.import_export,
                                size: 30,
                                color: Colors.white,
                              )
                            : (income - expense) > 0
                                ? Icon(
                                    Icons.arrow_upward,
                                    size: 30,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.arrow_downward,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: income - expense == 0
                        ? CircleAvatar(
                            radius: 90,
                            child: Icon(
                              Icons.assignment_turned_in_sharp,
                              size: 70,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.blue,
                          )
                        : CircleAvatar(
                            radius: 90,
                            child: Icon(
                              Icons.arrow_upward,
                              size: 70,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.green,
                          )),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Income",
                    style: GoogleFonts.spartan(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.kgreyColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "$income",
                        style: GoogleFonts.spartan(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.kgreyColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_upward,
                        color: ColorConstants.kwhiteColor,
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                      height: 25,
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundedProgressBar(
                              style: RoundedProgressBarStyle(
                                  colorProgress: Colors.green,
                                  backgroundProgress: Colors.grey[400],
                                  borderWidth: 0,
                                  widthShadow: 0),
                              borderRadius: BorderRadius.circular(24),
                              height: 7,
                              percent: (100 -
                                          (expense.toDouble() /
                                                  income.toDouble()) *
                                              100) >
                                      0
                                  ? (100 -
                                      (expense.toDouble() / income.toDouble()) *
                                          100)
                                  : 0),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Expense",
                    style: GoogleFonts.spartan(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.kgreyColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "$expense",
                        style: GoogleFonts.spartan(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.kgreyColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_downward,
                        color: ColorConstants.kwhiteColor,
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                      height: 25,
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundedProgressBar(
                              style: RoundedProgressBarStyle(
                                  colorProgress: Colors.red,
                                  backgroundProgress: Colors.grey[400],
                                  borderWidth: 0,
                                  widthShadow: 0),
                              borderRadius: BorderRadius.circular(24),
                              height: 7,
                              percent: (expense.toDouble() /
                                              income.toDouble()) *
                                          100 >
                                      0
                                  ? (expense.toDouble() / income.toDouble()) *
                                      100
                                  : 0),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  void choiceAction(String choice) {
    if (choice == Constants.PieChart) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PichartPage(this.income, this.expense);
      }));
    } else if (choice == Constants.About) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AboutPage();
      }));
    } else if (choice == Constants.Contact) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MycontactPage();
      }));
    } else if (choice == Constants.Share) {
      share();
    }
  }
}

class Constants {
  static const String PieChart = 'Chart View';
  static const String About = 'About';
  static const String Contact = 'Contact';
  static const String Share = 'Share';

  static const List<String> choices = <String>[PieChart, About, Contact, Share];
}
