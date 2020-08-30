import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double cost;
  final DateTime time;

  Transaction({
    @required this.cost,
    @required this.id,
    @required this.time,
    @required this.title,
  });
}
