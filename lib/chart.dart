import 'package:firstapp/chart_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recenttransaction;

  Chart(this.recenttransaction);

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recenttransaction.length; i++) {
        if (recenttransaction[i].date.day == weekday.day &&
            recenttransaction[i].date.month == weekday.month &&
            recenttransaction[i].date.year == weekday.year) {
          totalSum += recenttransaction[i].amount;
        }
      }
      print(DateFormat.E().format(weekday));
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekday).substring(0, 3),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionValues);
    return Container(
      // height: MediaQuery.of(context).size.height*0.4,
      child: Card(
          elevation: 6,
          margin: EdgeInsets.all(20),
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: groupedTransactionValues.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      data['day'],
                      data['amount'],
                      totalSpending == 0.0
                          ? 0.0
                          : (data['amount'] as double) / totalSpending),
                );
              }).toList(),
            ),
          )),
    );
  }
}
