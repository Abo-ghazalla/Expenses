import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    @required  this.transactionItem,
    @required this.removeTransaction,
  }) ;

  final Transaction transactionItem;
  final Function removeTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(7),
            child: FittedBox(
              child: Text(
                  "\$${transactionItem.cost.toStringAsFixed(2)}"),
            ),
          ),
        ),
        title: Text(
          transactionItem.title,
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Text(DateFormat.yMMMEd()
            .format(transactionItem.time)),

        trailing: MediaQuery.of(context).size.width > 400
            ?  FlatButton.icon(
                onPressed: () =>
                    removeTransaction(transactionItem.id),
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                label: Text("Delete"))
            : IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () =>
                    removeTransaction(transactionItem.id),
                color: Theme.of(context).errorColor,
              ),
        // that was an icon button to remove the transaction if needed
      ),
    );
  }
}