import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _lastSevenDaysTransactions;
  // that was a property which would include the last seven days transctions

  Chart(this._lastSevenDaysTransactions);
  // that was the constructor

  List<Map<String, Object>> get totalTransactionsForEveryDayInLastWeek {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double total = 0.0;

      for (var transaction in _lastSevenDaysTransactions) {
        if (transaction.time.day == weekDay.day &&
            transaction.time.month == weekDay.month &&
            transaction.time.year == weekDay.year) {
          total += transaction.cost;
        }
      }
      // that was a loop through this list and check every item if its date equals weekDay's date
      // and if true would increase the total spendings for this day

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": total
      };
    }).reversed.toList();
  }
  // that was a getter method which returns a seven-item list of maps
  // each map has a key of a weekday letter and a value of the total spendings for this day

  double get totalSpendingForThisWeek {
    // fold method loops through a list and it takes two arguments & returns a value.
    // the first is an intialization for the value which will be reruned,
    // the other is a function. this function takes two arguments the first is the name for the intial value we sent
    // for first argumnet for the fold menthod, and the other is a name for list's item we loops over it now.
    return totalTransactionsForEveryDayInLastWeek.fold(0.0,
        (total, transaction) {
      return total + transaction["amount"];
    });
  }
  // that was a getter to calculate the total spendings for this week from the list in line 14

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: totalTransactionsForEveryDayInLastWeek.map((tx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                tx['day'],
                tx['amount'],
                totalSpendingForThisWeek == 0
                    ? 0.0
                    : (tx['amount'] as double) / totalSpendingForThisWeek,
                // we check if the total spendings is 0 to avoid divide by zero
              ),
            );

            // that was the chart bars, to know more go to its file
          }).toList(),
        ),
      ),
    );
  }
}
