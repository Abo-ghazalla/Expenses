import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextFieldsAndButtonToInsertNewTransaction extends StatefulWidget {
  final Function addingTransactionIntoList;
  // that was a property to hold the incoming function, this function will trigger whenever "Add" button is pressed

  TextFieldsAndButtonToInsertNewTransaction(this.addingTransactionIntoList);

  @override
  _TextFieldsAndButtonToInsertNewTransactionState createState() =>
      _TextFieldsAndButtonToInsertNewTransactionState();
}

class _TextFieldsAndButtonToInsertNewTransactionState
    extends State<TextFieldsAndButtonToInsertNewTransaction> {
  final title = TextEditingController();
  final price = TextEditingController();
  //that was two properties for item's title and price and we would pass them to contreller of text field for each one

  DateTime enteredDate;

  void submitData() {
    var enteredTitel = title.text;
    var enteredPrice = double.parse(price.text);
    if (enteredTitel.isEmpty || enteredPrice <= 0 || enteredDate==null) {
      return;
    }
    // that was a validation to ensure that text fields are not empty while submitting

    widget.addingTransactionIntoList(enteredTitel, enteredPrice,enteredDate);

    Navigator.of(context).pop();
    // this line is to close the model bottem sheet after clicking sumbit or "Add"
  }

  void gettingDateFromUser() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate == null) {
        return;
      }
      setState(() {
        enteredDate = selectedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return // text fields
        SingleChildScrollView(
                  child: Card(
      elevation: 5,
      child: Container(
          padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom:MediaQuery.of(context).viewInsets.bottom+10 ),

          child: Column(
            //mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: "title",
                    hintText: 'Enter item\'s name',
                    border: OutlineInputBorder(),
                  ),
                  controller: title,
                  onSubmitted: (_) => submitData(),
                  // flutter by default needs argument from this function
                  // and the "_" char means I don't care about that argument's value
                ),
                // first text field for the item's name
              ),
              // this container is to meke padding under the first text field

              TextField(
                enableInteractiveSelection: false,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                  labelText: "cost",
                  hintText: 'Enter item\'s price',
                  border: OutlineInputBorder(),
                ),
                controller: price,
                onSubmitted: (_) => submitData(),
                // flutter by default needs argument from this function
                // and the "_" char means I don't care about that argument's value
              ),
              //second text field for item's price

              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(enteredDate == null
                            ? "No Date Chosen!"
                            : DateFormat.yMd().format(enteredDate))),
                    FlatButton(
                      child: Text("Choose Date"),
                      onPressed: gettingDateFromUser,
                      color: Colors.grey[400],
                      textColor: Theme.of(context).primaryColorDark,
                    )
                  ],
                ),
              ),
              // that was the date section

              RaisedButton(
                  elevation: 5,
                  color: Theme.of(context).primaryColor,
                  child: const Text(
                    "Add Transaction",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  textColor: Colors.white,
                  onPressed: submitData
                  // that was the function which passed from the argument
                  )
            ],
          ),
          // column wich contians the text fields and the "Add" button
      ),
    ),
        );
  }
}
