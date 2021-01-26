import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:budgetapp/common/color_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    TextStyle textStyle = TextStyle(color: Colors.white);

    return Scaffold(
      appBar: AppBar(
        title: Container(
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
              Column(
                children: [
                  FloatingActionButton.extended(
                    backgroundColor: const Color(0xFFFFC107),
                    foregroundColor: Colors.black,
                    onPressed: reset,
                    icon: Icon(Icons.add),
                    label: Text('NEW'),
                  ),
                ],
              )
            ],
          ),
        ),
        backgroundColor: ColorConstants.kblackColor,
      ),
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding + 15.0),
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
                            child: TextFormField(
                          keyboardType: TextInputType.datetime,
                          style: textStyle,
                          controller: termController,
                          validator: (String value) {
                            RegExp calenderDate = RegExp(
                                r'^((((0?[1-9]|[12]\d|3[01])[/](0?[13578]|1[02])[/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|[12]\d|30)[/](0?[13456789]|1[012])[/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|1\d|2[0-8])[/]0?2[/]((1[6-9]|[2-9]\d)?\d{2}))|(29[/]0?2[/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00)))|(((0[1-9]|[12]\d|3[01])(0[13578]|1[02])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|[12]\d|30)(0[13456789]|1[012])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|1\d|2[0-8])02((1[6-9]|[2-9]\d)?\d{2}))|(2902((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00))))$');

                            if (!calenderDate.hasMatch(value))
                              return 'Enter Valid Date';
                          },
                          decoration: InputDecoration(
                            labelText: 'Date',
                            hintText: 'DD/MM/YYYY',
                            hintStyle: TextStyle(
                                fontSize: 15.0, color: Colors.white54),
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                                color: Colors.yellowAccent, fontSize: 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFFFA726)),
                                borderRadius: BorderRadius.circular(5.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        )),
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
                                if (_formKey.currentState.validate()) {
                                  // this.displayResult = _calculateTotalReturns();
                                  _calculateTotalReturns();
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
      "date": termController.text,
      "moneytype": this._currentItemSelected,
      "time": DateTime.now().millisecondsSinceEpoch
    };

    User user = auth.currentUser;
    String id = user.uid;
    await FirebaseFirestore.instance
        .collection("user")
        .doc(id)
        .collection("entrydata")
        .add(map);
    reset();
  }

  reset() {
    setState(() {
      _currentItemSelected = _currencies[0];
      principalController.text = "";
      roiController.text = "";
      termController.text = "";
    });
  }
}
