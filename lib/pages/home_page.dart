import 'package:budgetapp/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../libmodels/user_model.dart';
import '../services/authentication_service.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  signOut() {
    auth.signOut();
  }

  checkAuth() async {
    auth.authStateChanges().listen((event) {
      if (event == null) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return LoginPage();
        }), (route) => false);
      }
    });
  }

  User _currentUser;
  userInformation() {
    User k = auth.currentUser;
    setState(() {
      _currentUser = k;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        centerTitle: true,
      ),
      body: _currentUser == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "uid is ${_currentUser.uid} , email is ${_currentUser.email}, name is ${_currentUser.displayName}",
                  textAlign: TextAlign.center,
                ),
                Center(
                  child: RaisedButton(
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    color: Colors.orange,
                    onPressed: () {
                      signOut();
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   final userRef = Firestore.instance.collection("users");
//   UserModel _currentUser;

//   String _uid;
//   String _username;
//   String _email;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getCurrentUser();
//   }

//   getCurrentUser() async {
//     UserModel currentUser = await context
//         .read<AuthenticationService>()
//         .getUserFromDB(uid: auth.currentUser.uid);

//     _currentUser = currentUser;

//     print("${_currentUser.username}");

//     setState(() {
//       _uid = _currentUser.uid;
//       _username = _currentUser.username;
//       _email = _currentUser.email;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("HomePage"),
//         centerTitle: true,
//       ),
//       body: _currentUser == null
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "uid is ${_uid} , email is ${_email}, name is ${_username}",
//                   textAlign: TextAlign.center,
//                 ),
//                 Center(
//                   child: RaisedButton(
//                     child: Text(
//                       "Logout",
//                       style: TextStyle(color: Colors.black, fontSize: 18),
//                     ),
//                     elevation: 8.0,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10))),
//                     color: Colors.orange,
//                     onPressed: () {
//                       context.read<AuthenticationService>().signOut();
//                     },
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
