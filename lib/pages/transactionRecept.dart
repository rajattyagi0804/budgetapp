import 'package:flutter/material.dart';

class TransactionRecept extends StatelessWidget {
  String description, money, moneytype, date;
  TransactionRecept(this.description, this.money, this.moneytype, this.date);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Back",
        ),
        backgroundColor: Colors.white10,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            _greenColors(this.description, context),
            _money(this.money, context),
            _getInfo(this.description, this.money, this.moneytype, this.date,
                context),
            _userAdress(context),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _greenColors(String description, BuildContext context) {
  return Positioned(
    top: 0,
    child: Container(
      height: 900, //250
      width: MediaQuery.of(context).size.width,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 7,
          ),
          CircleAvatar(
            child: Center(
                child: Text(
              description[0].toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white),
            )),
            radius: 40,
          ),
        ],
      ),
    ),
  );
}

Widget _money(String money, BuildContext context) {
  return Positioned(
    top: 90,
    child: Container(
      height: 900, //250
      width: MediaQuery.of(context).size.width,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "\u20b9 $money",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 50, color: Colors.black),
          )),
        ],
      ),
    ),
  );
}

Widget _getInfo(String description, String money, String moneytype, String date,
    BuildContext context) {
  return Positioned(
    top: 170,
    child: Container(
      margin: const EdgeInsets.all(20),
      height: 320,
      width: MediaQuery.of(context).size.width * 0.90,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Transaction Detail",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Colors.black)),
                Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.black,
                  size: 30,
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
              thickness: 4,
              height: 25,
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Title :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    SizedBox(
                      width: 20,
                    ),
                    Text(description,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: <Widget>[
                    Text("Date :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    SizedBox(
                      width: 20,
                    ),
                    Text(date,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: <Widget>[
                    Text("Money Type :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    SizedBox(
                      width: 20,
                    ),
                    moneytype == 'Income'
                        ? Text(moneytype,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black))
                        : Text(moneytype,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.red)),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: <Widget>[
                    Text("$moneytype :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    SizedBox(
                      width: 20,
                    ),
                    Text(money,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _userAdress(BuildContext context) {
  return Positioned(
    top: 550,
    child: Container(
      margin: EdgeInsets.all(20),
      height: 100,
      width: MediaQuery.of(context).size.width * 0.90,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(children: <Widget>[
            Text(
              '***Smart Budgeting***',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ])
//
          ),
    ),
  );
}
