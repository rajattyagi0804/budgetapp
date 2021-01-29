import 'package:budgetapp/Navigators/pagesnavigator.dart';
import 'package:budgetapp/pages/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  authChange() async {
    _auth.authStateChanges().listen((event) async {
      if (event != null) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return IndexPage();
        }), (route) => false);
      }
    });
  }

  bool _passwordVisible;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    authChange();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _key,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: 60,
                ),
              ),
              SliverToBoxAdapter(
                child: _title(),
              ),
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 100,
                ),
              ),
              SliverToBoxAdapter(
                child: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Name';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Name',
                      icon: const Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: const Icon(
                            Icons.person,
                            color: Colors.black,
                          )),
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
              SliverToBoxAdapter(
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Email';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Email',
                      icon: const Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: const Icon(
                            Icons.mail,
                            color: Colors.black,
                          )),
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
              SliverToBoxAdapter(
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Password';
                    }
                  },
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                      labelText: 'Create Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          )),
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 31),
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    focusColor: Colors.red,
                    onPressed: signUpwithEmailAndPassword,
                    label: Text(
                      'SignUp',
                      style: TextStyle(fontSize: 25),
                    ),
                    icon: Icon(Icons.create),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              SliverToBoxAdapter(
                child: _divider(),
              ),
              SliverToBoxAdapter(
                child: _loginAccountLabel(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'S',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
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

  _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text(
            'or',
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  signUpwithEmailAndPassword() async {
    if (_key.currentState.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: this.emailController.text,
                password: this.passwordController.text);
        if (userCredential != null) {
          userCredential.user
              .updateProfile(displayName: this.nameController.text);
        }
      } on FirebaseAuthException catch (e) {
        errorDialogue(e.code.toString(), context);
      }
    }
  }

  Future<Widget> errorDialogue(String message, context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(message),
          );
        });
  }
}
