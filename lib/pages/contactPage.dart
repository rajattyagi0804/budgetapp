import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class MycontactPage extends StatelessWidget {
  _makingPhoneCall() async {
    const url = 'tel:9876543210';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendEmail() async {
    const url = 'mailto:abc@gmail.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 200.0,
                ),
                Text(
                  'Welcome to Smart Budgeting',
                  style: TextStyle(
                      fontSize: 27.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                Text(
                  'For further Query',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.black,
                  onPressed: _makingPhoneCall,
                  icon: Icon(Icons.call),
                  label: Text('Call'),
                ),
                Container(
                  height: 20.0,
                ),
                FloatingActionButton.extended(
                  backgroundColor: Colors.red[700],
                  foregroundColor: Colors.black,
                  onPressed: _sendEmail,
                  icon: Icon(Icons.mail),
                  label: Text('Email'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
