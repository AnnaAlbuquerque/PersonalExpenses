import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {

  final Function addExpense;

  NewExpense(this.addExpense);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData(){
    final  enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0){
      return;
    }

    widget.addExpense(enteredTitle, enteredAmount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  controller: titleController,
                  onSubmitted:(_) => submitData(),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                  controller: amountController,
                  onSubmitted:(_) => submitData(),
                ),
                FlatButton(
                  onPressed: submitData,
                  child: Text('Add Transaction'),
                  textColor: Colors.purple,
                ),
              ]),
        ));
  }
}
