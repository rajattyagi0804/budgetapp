import 'package:budgetapp/pages/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  signOut() {
    auth.signOut();
  }

  checkAuth() async {
    auth.authStateChanges().listen((event) {
      if (event == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return SignIn();
        }), (route) => false);
      }
    });
  }

  User user;
  bool issignedIn = false;
  getUser() async {
    User firebaseUser = auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = auth.currentUser;
    if (firebaseUser != null) {
      setState(() {
        user = firebaseUser;
        issignedIn = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
    checkAuth();
  }

  Widget _greenColors() {
    return Positioned(
      top: 0,
      child: Container(
        color: Colors.black,
        height: 900, //250
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              child: Center(
                  child: Text(
                "${user.displayName.toString()[0].toUpperCase()}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 70,
                    color: Colors.white),
              )),
              radius: 60,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getInfo() {
    return Positioned(
      top: 200,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 200,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("User Information",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Colors.black)),
              Divider(
                thickness: 3,
                indent: 20,
                endIndent: 20,
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("User Name :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black)),
                      SizedBox(
                        width: 10,
                      ),
                      Text("${user.displayName}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Email :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black)),
                      SizedBox(
                        width: 10,
                      ),
                      Text("${user.email}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userAdress() {
    return Positioned(
      top: 450,
      child: Container(
        margin: EdgeInsets.all(20),
        height: 100,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(20)),
        child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Column(children: <Widget>[
              FloatingActionButton.extended(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.black,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        content: Text("Do you want to LogOut ?"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("YES"),
                            onPressed: () {
                              signOut();

                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text("NO"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                label: Text(
                  'LOGOUT',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              )
            ])),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          "Profile",
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: issignedIn == false
          ? Container(
              color: Colors.black,
              child: Center(child: CircularProgressIndicator()))
          : Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                  _greenColors(),
                  _getInfo(),
                  _userAdress(),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
    );
  }
}
