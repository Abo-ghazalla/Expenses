import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String labelForDay;
  final double totalSpendingForDay;
  final double percentageForDaySpendingToWeek;

  const ChartBar(
    this.labelForDay,
    this.totalSpendingForDay,
    this.percentageForDaySpendingToWeek,
  );
  // that was the constructor

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * .09,
            child: FittedBox(
              child: Text("\$${totalSpendingForDay.toStringAsFixed(0)}"),
            ),
          ),
          // text lable show total amount of spendings to its day

          SizedBox(height: constraints.maxHeight * .02),
          // size box works as a padding

          Container(
            height: constraints.maxHeight * .77,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentageForDaySpendingToWeek,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
            // Stack widget to draw containers over eahc others
          ),
          SizedBox(height: constraints.maxHeight * 0.02),
          Container(
            height: constraints.maxHeight * .1,
            child: FittedBox(
              child: Text(
                labelForDay,
              ),
            ),
          ),
        ],
      );
    });
  }
}
