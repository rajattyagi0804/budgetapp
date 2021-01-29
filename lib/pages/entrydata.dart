import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:budgetapp/common/color_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Income', 'Expense'];
  final double _minimumPadding = 5.0;
  FirebaseAuth auth = FirebaseAuth.instance;
  var _currentItemSelected = '';
  bool dateNotSelected = true;
  DateTime selectedDate = DateTime.now();
  String date;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateNotSelected = false;
      });
  }

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
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
        title: Container(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Data Entry',
                    style: GoogleFonts.spartan(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.kwhiteColor,
                    ),
                  ),
                ],
              ),
            ],
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
                          return 'Please Enter The Description !';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter the Amount Description',
                        hintStyle:
                            TextStyle(fontSize: 15.0, color: Colors.white54),
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                            color: Colors.yellowAccent, fontSize: 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFFFA726)),
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
                            borderSide: BorderSide(color: Color(0xFFFFA726)),
                            borderRadius: BorderRadius.circular(5.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color(0xFFFFA726))),
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
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                          value: _currentItemSelected,
                          onChanged: (String newValueSelected) {
                            _onDropDownItemSelected(newValueSelected);
                          },
                        ))
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
                              'Save',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate() &&
                                    dateNotSelected == false) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        content: Text(
                                            "Are You Sure Want To Proceed ?"),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("YES"),
                                            onPressed: () {
                                              _calculateTotalReturns();

                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          FlatButton(
                                            child: Text("NO"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          FlatButton(
                                            child: Text("CANCEL"),
                                            onPressed: () {
                                              reset();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
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

  void _onDropDownItemSelected(newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  void _calculateTotalReturns() async {
    Map<String, dynamic> map = {
      "description": principalController.text,
      "money": int.parse(roiController.text),
      "date": date,
      "moneytype": this._currentItemSelected,
      "time": DateTime.now().millisecondsSinceEpoch
    };

    User user = auth.currentUser;
    String id = user.uid;
    await FirebaseFirestore.instance
        .collection("user")
        .doc(id)
        .collection("entrydata")
        .add(map)
        .then((value) => showDialog(
            context: context,
            builder: (context) {
              Future.delayed(Duration(seconds: 1), () {
                Navigator.of(context).pop(true);
              });
              return AlertDialog(
                content: Text('Success!!'),
              );
            }));
    reset();
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

  reset() {
    setState(() {
      dateNotSelected = true;
      _currentItemSelected = _currencies[0];
      principalController.text = "";
      roiController.text = "";
    });
  }
}
