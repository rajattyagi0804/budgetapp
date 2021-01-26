import 'package:flutter/material.dart';
import 'package:budgetapp/common/color_constants.dart';
import 'package:google_fonts/google_fonts.dart';

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
                            fontWeight: FontWeight.bold, fontSize: 20),
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
              child: Text(
                amount,
                style: GoogleFonts.openSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.kwhiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 15,
      )
    ],
  );
}
