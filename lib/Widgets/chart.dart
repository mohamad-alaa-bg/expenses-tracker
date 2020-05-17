import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransaction;

  Chart(this._recentTransaction);

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      double totalSum = 0.0;
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      for (int i = 0; i < _recentTransaction.length; i++) {
        if (_recentTransaction[i].date.day == weekDay.day &&
            _recentTransaction[i].date.month == weekDay.month &&
            _recentTransaction[i].date.year == weekDay.year) {
          totalSum += _recentTransaction[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupTransactionValues.fold(
        0.0, (sum, element) => sum += element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
     // height: MediaQuery.of(context).size.height *0.4,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupTransactionValues.map((e) {
              return Flexible(
                fit:FlexFit.tight ,
                child: ChartBar(
                  e['day'],
                  e['amount'],
                  totalSpending ==0 ? 0.0 : (e['amount'] as double) / totalSpending  ,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
