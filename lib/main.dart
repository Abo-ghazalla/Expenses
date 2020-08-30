import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './models/transaction.dart';
import './widgets/viewing_transactions_list.dart';
import './widgets/TextFields_and_button_to_insert_new_transcation.dart';
import 'widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    //   SystemChrome.setPreferredOrientations(
    //   [DeviceOrientation.portraitUp,],
    // );
    //these lines are for prevent app from rotate in android, search online for IOS
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        appBarTheme: AppBarTheme(
            // this is for styling text only in app bar in every single page
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: "Galada",
                    fontSize: 25,
                  ),
                )),
        textTheme: TextTheme(
          caption: TextStyle(
            fontSize: 22,
            //color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
          headline3: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactionsList = [
    //Transaction(
    // cost: 10.5, id: "msa", time: DateTime.now(), title: "Insert from code")
  ];
  // that was the list which will store all user's transactions inside it

  List<Transaction> get _lastSevenDaysTransactions {
    return _userTransactionsList.where((tx) {
      return tx.time.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
    // using where method,
    //loop through every trasaction in list and if it is in last week insert it in a new created list
    // and finally return that new list
  }
  // that was a getter method which returns a list of last week transactions

  void insertNewTransactionIntoList(String title, double cost, DateTime date) {
    final newTransaction = Transaction(
      title: title, // get the item's title from the user
      cost: cost, // get the item's price from the user
      time: date,
      id: DateTime.now().toString(),
    );
    // that was an intialization to a new transction depends on the user's inputs
    // to know more about "transaction" class, go to its file

    setState(() {
      _userTransactionsList.add(newTransaction);
    });
    // calling setState funtion to insert the new transcation into the list and rerender the UI
  }
  // that was the function which would trigger when the user hits "Add" button

  void _startAddingNewTransaction(BuildContext contx) {
    showModalBottomSheet(
      //isScrollControlled: true,
      context: contx,
      builder: (_) {
        // flutter by default needs argument from this function
        // and the "_" char means I don't care about that argument's value
        return TextFieldsAndButtonToInsertNewTransaction(insertNewTransactionIntoList);
      },
    );
  }
  // that was a function which is triggered when any of two icon buttons is pressed

  void _removeTransaction(String id) {
    setState(() {
      _userTransactionsList.removeWhere((transaction) => transaction.id == id);
    });
  }
  // that was a function to remove item from the list depending on item's id

  bool _showChart = false;

 
  

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);

    final bool isLandscapeMode =
       mediaQuery.orientation == Orientation.landscape;
    // that was a variable to store the orientation of the device


    final appBar = AppBar(
      title: Text("Expenses App"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add_box),
          onPressed: () => _startAddingNewTransaction(context),
        )
      ],
    );
    // we declare appBar in variable to use this var to access the height of the app bar with media query

     double chartFactor = .4;
     double listFactor = .6;

    if (isLandscapeMode) {
      chartFactor = listFactor =0.65;
    }

    final showingChart = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context)
                  .padding
                  .top) * // last term to calculate the status bar of the phone

          chartFactor,
      child: Chart(_lastSevenDaysTransactions),
    );
    // this was a variable to show the chart section, go to the widget file to see more about it

    final showingTransactionsList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          listFactor,
      child: ViewingTransactionsList(_userTransactionsList, _removeTransaction),
    );
    // this was a variable to show transactions list, go to the widget file to see more about it

    return Scaffold(
      appBar: appBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              // this kind of buttons whatever its order in the code,
              // always appears at the end of the app UI
              child: Icon(Icons.add),

              onPressed: () => _startAddingNewTransaction(context),
            ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscapeMode)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Show chart"),
                  Switch.adaptive(
                      value: _showChart,
                      onChanged: (newValue) {
                        setState(() {
                          _showChart = newValue;
                        });
                      })
                ],
              ),
            //that was a swith button which whould be shown if landscape mode is ON

            if (isLandscapeMode)
              _showChart ? showingChart : showingTransactionsList,
            // that was what would be shown if landscape is ON

            if (!isLandscapeMode)
              showingChart,
            if (!isLandscapeMode)
              showingTransactionsList,
            //that was what whould be shown if landscape is OFF
          ],
        ),
      ),
    );
  }
}
