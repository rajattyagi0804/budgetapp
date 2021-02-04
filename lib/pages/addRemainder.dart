import 'dart:math';

import 'package:budgetapp/common/color_constants.dart';
import 'package:budgetapp/pages/home_page_sceen.dart';
import 'package:budgetapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddRemainder extends StatefulWidget {
  @override
  _AddRemainderState createState() => _AddRemainderState();
}

class _AddRemainderState extends State<AddRemainder> {
  var _formKey = GlobalKey<FormState>();

  final double _minimumPadding = 5.0;
  FirebaseAuth auth = FirebaseAuth.instance;

  bool dateNotSelected = true;
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  String date;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now().add(Duration(days: 1)),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;

        dateNotSelected = false;
      });
  }

  int income = 0, expense = 0;

  QuerySnapshot snapshot;
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

  FirestoreFunction firestoreFunction = FirestoreFunction();
  int totalMoney = 0;
  User user;
  String id;
  getRemainders() async {
    user = auth.currentUser;
    id = user.uid;
    QuerySnapshot k = await firestoreFunction.getRemainders(id);
    if (k != null) {
      for (var i = 0; i < k.docs.length; i++) {
        if (DateTime.now().isBefore(k.docs[i].get("date").toDate())) {
          totalMoney += k.docs[i].get("money");
        }
      }

      setState(() {});
    }
  }

  int k = 1;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  @override
  void initState() {
    super.initState();
    initializing();
    getRemainders();
    getIncome();
  }

  void initializing() async {
    androidInitializationSettings = AndroidInitializationSettings("rss");
    iosInitializationSettings = IOSInitializationSettings();
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future<void> notificationAfterSec(var id, title, var dateTime) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'second channel ID', 'second Channel title', 'second channel body',
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.schedule(id, 'Alert',
        'Your Payment for $title is due today', dateTime, notificationDetails);
  }

  Future onSelectNotification(String payLoad) async {
    if (payLoad != null) {
      return HomePageScreen();
    }
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    date = DateFormat('dd/MM/yyyy').format(selectedDate);
    TextStyle textStyle = TextStyle(color: Colors.white);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Reminders ',
          style: GoogleFonts.spartan(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: ColorConstants.kwhiteColor,
          ),
        ),
        backgroundColor: ColorConstants.kblackColor,
      ),
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.only(
                top: _minimumPadding + 30.0,
                bottom: _minimumPadding + 15.0,
                left: _minimumPadding + 15.0,
                right: _minimumPadding + 15.0),
            child: ListView(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: textStyle,
                      controller: principalController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please Enter The Reminder Title !';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Reminder Title',
                        hintText: 'Enter the Amount Reminder Title',
                        hintStyle:
                            TextStyle(fontSize: 15.0, color: Colors.white54),
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                            color: Colors.yellowAccent, fontSize: 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                            borderRadius: BorderRadius.circular(5.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: textStyle,
                      controller: roiController,
                      validator: (String value) {
                        RegExp calender = RegExp(r'[^0-9]');

                        if (value.isEmpty || calender.hasMatch(value)) {
                          return 'Please Enter The Money !';
                        }
                        if (int.parse(value) > 9999999) {
                          return 'Please Enter less than 9999999';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Money',
                        hintText: 'Enter your Amount',
                        hintStyle:
                            TextStyle(fontSize: 15.0, color: Colors.white54),
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                            color: Colors.yellowAccent, fontSize: 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                            borderRadius: BorderRadius.circular(5.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      top: _minimumPadding,
                      bottom: _minimumPadding,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Colors.teal)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                dateNotSelected == true
                                    ? Text(
                                        'Date',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      )
                                    : Text(
                                        '$date',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                IconButton(
                                    icon: Icon(
                                      Icons.calendar_today_outlined,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      _selectDate(context);
                                    })
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                      ],
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(bottom: _minimumPadding, top: 20.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            child: Text(
                              'Set Reminder',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate() &&
                                    dateNotSelected == false) {
                                  if (int.parse(roiController.text) +
                                          totalMoney <=
                                      income - expense) {
                                    _calculateTotalReturns();
                                  } else {
                                    errorDialogue(
                                        "Not Enough Balance Add balance then try again!!",
                                        context);
                                  }
                                } else {
                                  errorDialogue("Choose Date", context);
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    this.displayResult,
                    style: textStyle,
                  ),
                )
              ],
            )),
      ),
    );
  }

  void _calculateTotalReturns() async {
    Map<String, dynamic> map = {
      "title": principalController.text,
      "money": int.parse(roiController.text),
      "date": selectedDate,
    };

    User user = auth.currentUser;
    String id = user.uid;
    await FirebaseFirestore.instance
        .collection("user")
        .doc(id)
        .collection("remainder")
        .add(map)
        .then((value) {
      return showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              content: Text('Success!!'),
            );
          });
    });

    notificationAfterSec(
        Random().nextInt(10), principalController.text, selectedDate);
    Navigator.of(context).pop(true);
  }

  Future<Widget> errorDialogue(String message, context) async {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pop(context);
          });
          return AlertDialog(
            title: Text('Error'),
            content: Text(message),
          );
        });
  }
}
