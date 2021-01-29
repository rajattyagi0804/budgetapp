import 'package:budgetapp/pages/home_page_sceen.dart';
import 'package:budgetapp/pages/Transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budgetapp/pages/entrydata.dart';
import '../pages/profilepage.dart';

class CurrentScreenIndex extends StatelessWidget {
  final int index;

  CurrentScreenIndex(
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 1:
        {
          return SIForm();
        }
        break;
      case 2:
        {
          return Readddata();
        }
        break;
      case 3:
        {
          return ProfilePage();
        }
        break;
      default:
        {
          return HomePageScreen();
        }
        break;
    }
  }
}
