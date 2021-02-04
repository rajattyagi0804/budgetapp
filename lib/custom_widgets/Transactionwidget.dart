import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:budgetapp/common/color_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

Widget transactionCard(String title, var money, String moneytype, String date) {
  // final numberFormat = new NumberFormat("##,###", "en_US");
  String amount = moneytype == "Income" ? "+$money" : "-$money";

  return Column(
    children: [
      Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: ColorConstants.gblackColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: ColorConstants.korangeColor,
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Center(
                      child: Text(
                        title[0],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        title,
                        style: GoogleFonts.spartan(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.kwhiteColor,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        date,
                        style: GoogleFonts.spartan(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.kgreyColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
                padding: const EdgeInsets.only(right: 15),
                child: moneytype == 'Income'
                    ? Text(
                        amount,
                        style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      )
                    : Text(
                        amount,
                        style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      )),
          ],
        ),
      ),
      SizedBox(
        height: 15,
      )
    ],
  );
}

Widget remainderCard(String title, var money, Timestamp date) {
  String datetime = DateFormat('dd/MM/yyyy').format(date.toDate());
  return Column(
    children: [
      Container(
        height: 80,
        decoration: DateTime.now().isAfter(date.toDate())
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.red,
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.green,
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: ColorConstants.kwhiteColor,
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Center(
                      child: Text(
                        title[0],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: ColorConstants.korangeColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        title,
                        style: GoogleFonts.spartan(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.kwhiteColor,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        datetime,
                        style: GoogleFonts.spartan(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.kwhiteColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  money.toString(),
                  style: GoogleFonts.openSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
      SizedBox(
        height: 15,
      )
    ],
  );
}

Widget notificationCard(String title, var money, Timestamp date) {
  String datetime = DateFormat('dd/MM/yyyy').format(date.toDate());
  return Positioned(
    child: Container(
      margin: const EdgeInsets.only(top: 7, bottom: 7, left: 15, right: 15),
      height: 110,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red)),
                  Text(
                    datetime,
                    style: GoogleFonts.spartan(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.kblackColor,
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
                indent: 12,
                endIndent: 12,
                color: Colors.black,
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: <Widget>[
                  Text("Your $title for $money is due today!!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                ],
              )
            ],
          )),
    ),
  );
}
