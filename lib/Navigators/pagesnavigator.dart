import 'package:budgetapp/common/color_constants.dart';
import 'package:budgetapp/common/current_screen_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int selectedOptionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.kblackColor,
        bottomNavigationBar: _buildBottomNavigationBarPortrait(),
        body: CurrentScreenIndex(selectedOptionIndex),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedOptionIndex = index;
    });
  }

  Widget _buildBottomNavigationBarPortrait() {
    var bottomNavigationBarItem = BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      label: 'Home',
    );
    return BottomNavigationBar(
      items: [
        bottomNavigationBarItem,
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'Data',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.history),
          label: 'Transaction',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.person,
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedOptionIndex,
      onTap: _onItemTapped,
      backgroundColor: ColorConstants.kblackColor,
      selectedItemColor: ColorConstants.korangeColor,
      unselectedItemColor: ColorConstants.kwhiteColor,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
  }
}
