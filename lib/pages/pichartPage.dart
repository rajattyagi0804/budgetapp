import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart'; // import the package

// ignore: must_be_immutable
class PichartPage extends StatefulWidget {
  final int income, expense;
  PichartPage(this.income, this.expense);

  @override
  _PichartPageState createState() => _PichartPageState();
}

class _PichartPageState extends State<PichartPage> {
  Map<String, double> data = new Map();

  adddata() {
    double expense = widget.expense.toDouble();
    double income = widget.income.toDouble();

    income = 100 - (expense / income) * 100;
    expense = 100 - income;

    data.addAll(
      {
        'Income': income,
        'Expense': expense,
      },
    );
  }

  @override
  void initState() {
    adddata();
    super.initState();
  }

  List<Color> _colors = [Colors.green, Colors.red];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "Back",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              PieChart(
                dataMap: data,
                colorList: _colors,
                animationDuration: Duration(milliseconds: 1500),
                chartLegendSpacing: 10.0,
                chartRadius: MediaQuery.of(context).size.width / 1.7,
                showChartValuesInPercentage: true,
                showChartValues: true,
                showChartValuesOutside: false,
                chartValueBackgroundColor: Colors.grey[200],
                showLegends: true,
                legendPosition: LegendPosition.bottom,
                decimalPlaces: 1,
                showChartValueLabel: true,
                initialAngle: 0,
                chartValueStyle: defaultChartValueStyle.copyWith(
                  color: Colors.blueGrey[900].withOpacity(0.9),
                ),
                chartType: ChartType.disc,
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
