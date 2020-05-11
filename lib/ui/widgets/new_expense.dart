import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  final Function addExpense;

  NewExpense(this.addExpense);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    // just to avoid the error "invalid double"
    if (_amountController.text.isEmpty) {
      return;
    }

    final _enteredTitle = _titleController.text;
    final _enteredAmount = double.parse(_amountController.text);

    if (_enteredTitle.isEmpty || _enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addExpense(
      _enteredTitle,
      _enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: this.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            /*This will be used to adjust the screen with the keyboard, so the keyboard
              doesn't overlap some information
            */
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                  controller: _amountController,
                  onSubmitted: (_) => _submitData(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(_selectedDate == null
                              ? 'No Date Chosen!'
                              : 'Picked Date: ${DateFormat("dd/MM/yyyy").format(_selectedDate)}')),
                      Semantics(
                        label: "Choose date button",
                        hint: "Press to choose the date of your transaction",
                        button: true,
                        child: FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          child: Text(
                            'Choose Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: _presentDatePicker,
                        ),
                      ),
                    ],
                  ),
                ),
                Semantics(
                  button: true,
                  label: "Add transaction button",
                  hint: "Press to add the new transaction",
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    child: Text('Add Transaction'),
                    onPressed: _submitData,
                  ),
                ),
              ]),
        )
      ),
    );
  }
}
