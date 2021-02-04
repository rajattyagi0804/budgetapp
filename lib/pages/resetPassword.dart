import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Password Reset",
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: Colors.blueGrey,
        ),
        backgroundColor: Colors.blueGrey,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _key,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 100,
                  ),
                ),
                SliverToBoxAdapter(
                  child: _title(),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 160,
                  ),
                ),
                SliverToBoxAdapter(
                  child: TextFormField(
                    controller: email,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Email';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: "Enter Email",
                        icon: const Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      focusColor: Colors.red,
                      onPressed: resetPassWord,
                      label: Text(
                        'Reset',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  errorDialogue(String message, context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Ok',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
        });
  }

  Widget _title() {
    return RichText(
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
              style: TextStyle(color: Colors.black, fontSize: 50),
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
              style: TextStyle(color: Colors.limeAccent[700], fontSize: 50),
            ),
          ]),
    );
  }

  resetPassWord() async {
    if (_key.currentState.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
        errorDialogue("Check Your Email", context);
      } on FirebaseAuthException catch (e) {
        errorDialogue(e.toString(), context);
      }
    }
  }
}
