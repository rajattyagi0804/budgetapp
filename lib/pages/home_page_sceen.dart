import 'package:bezier_chart/bezier_chart.dart';
import 'package:budgetapp/common/color_constants.dart';
import 'package:budgetapp/custom_widgets/graph_card_widget.dart';
import 'package:budgetapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  var income = 0, expense = 0;
  FirebaseAuth auth = FirebaseAuth.instance;

  final numberFormat = new NumberFormat("##,###.00#", "en_US");
  Color color = ColorConstants.gblackColor;
  Color fcolor = ColorConstants.kgreyColor;
  bool isActive = false;
  int activeIndex;
  FirestoreFunction firestoreFunction = FirestoreFunction();
  getIncome() async {
    String id = auth.currentUser.uid;
    QuerySnapshot k = await firestoreFunction.getUserInformation(id);
    if (k != null) {
      for (var i = 0; i < k.docs.length; i++) {
        if (k.docs[i].get("moneytype") == "Income") {
          income += k.docs[i].get("money");
        } else {
          expense += k.docs[i].get("money");
        }
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIncome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.kblackColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.short_text,
                    color: ColorConstants.kwhiteColor,
                  ),
                  Icon(
                    Icons.more_vert,
                    color: ColorConstants.kwhiteColor,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Your Balance",
                style: GoogleFonts.spartan(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.kwhiteColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Money Received",
                style: GoogleFonts.spartan(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.kgreyColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${income - expense}",
                    style: GoogleFonts.openSans(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.kwhiteColor,
                    ),
                  ),
                  Row(
                    children: [
                      // Text(
                      //   "10%",
                      //   style: GoogleFonts.spartan(
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.w500,
                      //     color: ColorConstants.kwhiteColor,
                      //   ),
                      // ),
                      income - expense > 0
                          ? Icon(
                              Icons.arrow_upward,
                              size: 30,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.arrow_downward,
                              size: 30,
                              color: Colors.white,
                            ),

                      // Icon(
                      //   Icons.arrow_upward,
                      //   color: ColorConstants.kwhiteColor,
                      // ),
                    ],
                  )
                ],
              ),

              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: income - expense > 0
                        ? CircleAvatar(
                            radius: 70,
                            child: Icon(
                              Icons.arrow_upward,
                              size: 50,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.green,
                          )
                        : CircleAvatar(
                            child: Icon(
                              Icons.arrow_downward,
                              size: 50,
                              color: Colors.white,
                            ),
                            radius: 70,
                            backgroundColor: Colors.red[900],
                          )),
              ),

              // Center(
              //   child: Container(
              //     height: MediaQuery.of(context).size.height / 2.5,
              //     width: MediaQuery.of(context).size.width,
              //     child: BezierChart(
              //       bezierChartScale: BezierChartScale.CUSTOM,
              //       selectedValue: 1,
              //       xAxisCustomValues: [1, 5, 10, 15, 20, 25, 30],
              //       series: const [
              //         BezierLine(
              //           label: "june",
              //           lineColor: ColorConstants.korangeColor,
              //           dataPointStrokeColor: ColorConstants.kwhiteColor,
              //           dataPointFillColor: ColorConstants.korangeColor,
              //           lineStrokeWidth: 3,
              //           data: const [
              //             DataPoint<double>(value: 100, xAxis: 1),
              //             DataPoint<double>(value: 130, xAxis: 5),
              //             DataPoint<double>(value: 300, xAxis: 10),
              //             DataPoint<double>(value: 150, xAxis: 15),
              //             DataPoint<double>(value: 75, xAxis: 20),
              //             DataPoint<double>(value: 100, xAxis: 25),
              //             DataPoint<double>(value: 250, xAxis: 30),
              //           ],
              //         ),
              //       ],
              //       config: BezierChartConfig(
              //         startYAxisFromNonZeroValue: true,
              //         verticalIndicatorFixedPosition: false,
              //         bubbleIndicatorColor: ColorConstants.gblackColor,
              //         bubbleIndicatorLabelStyle:
              //             TextStyle(color: ColorConstants.kwhiteColor),
              //         bubbleIndicatorTitleStyle:
              //             TextStyle(color: ColorConstants.kwhiteColor),
              //         bubbleIndicatorValueStyle:
              //             TextStyle(color: ColorConstants.kwhiteColor),
              //         footerHeight: 40,
              //         displayYAxis: false,
              //         stepsYAxis: 15,
              //         displayLinesXAxis: false,
              //         xAxisTextStyle: TextStyle(
              //           color: ColorConstants.kblackColor,
              //         ),
              //         backgroundGradient: LinearGradient(
              //           colors: [
              //             ColorConstants.kblackColor,
              //             ColorConstants.kblackColor,
              //             ColorConstants.kblackColor,
              //             ColorConstants.kblackColor
              //           ],
              //           begin: Alignment.topCenter,
              //           end: Alignment.bottomCenter,
              //         ),
              //         snap: false,
              //       ),
              //     ),
              //   ),
              // ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 3.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: ColorConstants.korangeColor,
                    ),
                    child: Center(
                      child: Text(
                        "Apr to Jun",
                        style: GoogleFonts.spartan(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.kwhiteColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GraphCardWidget(
                    title: "1 \n Month",
                    activeColor: color,
                    fontColor: fcolor,
                    isActive: isActive,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GraphCardWidget(
                    title: "6 \n Month",
                    activeColor: color,
                    fontColor: fcolor,
                    isActive: isActive,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GraphCardWidget(
                    title: "1 \n Year",
                    activeColor: color,
                    fontColor: fcolor,
                    isActive: isActive,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Income",
                    style: GoogleFonts.spartan(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.kgreyColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "$income",
                        style: GoogleFonts.spartan(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.kgreyColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_downward,
                        color: ColorConstants.kwhiteColor,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Expense",
                    style: GoogleFonts.spartan(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.kgreyColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "$expense",
                        style: GoogleFonts.spartan(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.kgreyColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_upward,
                        color: ColorConstants.kwhiteColor,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
