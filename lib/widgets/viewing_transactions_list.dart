import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transactions_item.dart';


class ViewingTransactionsList extends StatelessWidget {
  final List<Transaction> _transactionsList;
  // that was a property to hold the transactions list which will be showed using this widget

  final Function removeTransaction;

  ViewingTransactionsList(this._transactionsList, this.removeTransaction);
  // that was the constructor for this class

  @override
  Widget build(BuildContext context) {
    return _transactionsList.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  "No transctions yet",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                // that was an empty box works as margin

                Container(
                  height: constraints.maxHeight*.7,
                  //width: 365,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        // that was what would be shown if the there is no transactions
        // we used LayoutBuilder to calculate the height dynamically of the image

        : Container(
            child: ListView.builder(
              // this argument is for looping over every element in the transction list to build it in UI
              itemBuilder: (ctx, index) {
                // first argument is not called by you 'developer' but by Flutter
                // the second one is index for the element Flutter is working on in the list
                return TransactionItem(transactionItem: _transactionsList[index], removeTransaction: removeTransaction);
              },
              itemCount: _transactionsList.length,
            ),
          );
  }
}


