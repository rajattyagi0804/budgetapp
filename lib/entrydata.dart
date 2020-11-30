import 'package:flutter/material.dart';
// import 'thispage.dart';
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'Entry Data',
//     home: SIForm(),
//     theme: ThemeData(
//         brightness: Brightness.dark,
//         primaryColor: Colors.indigo,
//         accentColor: Colors.indigoAccent),
//   )
//   );
// }

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
//			resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Entry Page'),
      ),
backgroundColor: Colors.black,
      body: 
      Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(20.0),
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
                          return 'Enter Description';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Enter the Amount Description',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: roiController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter Money';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Money',
                          hintText: 'Enter your Amount',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
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
                            if (value.isEmpty) {
                              return 'Enter your Date';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Date',
                              hintText: 'DD/MM/YYYY',
                              labelStyle: textStyle,
                              errorStyle: TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 15.0
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currentItemSelected,
                          onChanged: (String newValueSelected) {
                            // Your code to execute, when a menu item is selected from dropdown
                            _onDropDownItemSelected(newValueSelected);
                          },
                        )
                        )
                        
                      ],
                    )),
                    
                Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimumPadding, top: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Theme.of(context).primaryColorDark,
                            child: Text(
                              'Add',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate()) {
                            this.displayResult= _calculateTotalReturns();
                            
                                }
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              'Reset',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
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
            )
            ),
      ),
    );
  }

  void _onDropDownItemSelected(newValueSelected) {
    setState(() {
      // print(newValueSelected);
      this._currentItemSelected = newValueSelected;
    });
  }

    String _calculateTotalReturns() {
    double roi = double.parse(roiController.text);
    String navya=principalController.text;
    String n2=termController.text;
    String n3=this._currentItemSelected;
    //  return rajat(navya,roi,n2,n3);
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}