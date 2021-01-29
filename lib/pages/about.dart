import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'S',
                        style: GoogleFonts.portLligatSans(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 70,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffe46b10),
                        ),
                        children: [
                          TextSpan(
                            text: 'mart',
                            style:
                                TextStyle(color: Colors.purple, fontSize: 50),
                          ),
                          TextSpan(
                            text: ' B',
                            style: TextStyle(color: Colors.green, fontSize: 70),
                          ),
                          TextSpan(
                            text: 'udge',
                            style: TextStyle(color: Colors.white, fontSize: 50),
                          ),
                          TextSpan(
                            text: 'ting',
                            style: TextStyle(
                                color: Colors.limeAccent[700], fontSize: 50),
                          ),
                        ]),
                  ),
                ),
                new Text(
                  'Make your life easier',
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Column buildButtonColumn(IconData icon, String label) {
      Color color = Theme.of(context).primaryColor;

      return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Icon(icon, color: color),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        '''This app is used to make life easier as it controlls your budget. 
This app will keep track of your income and expenses by just taking a few information of yours and calculate the budget there after . 
This also helps you spend your money wisely.

Terms of use -
1. On the data tab, add your details regarding description, amount and a single category of income or expense.
2. You can check this transaction details in transaction interface. 
3. Now check your balance on the home page.''',
        softWrap: true,
        style: new TextStyle(
          color: Colors.white,
        ),
      ),
    );

    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        title: new Text(
          'About ',
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: new ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          titleSection,
          textSection,
          Divider(
            color: Colors.white,
            thickness: 3,
            indent: 20,
            endIndent: 20,
          )
        ],
      ),
    );
  }
}
