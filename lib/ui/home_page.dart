import 'package:expense_planner/ui/widgets/expenses_list.dart';
import 'package:expense_planner/ui/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import './widgets/new_expense.dart';
import './widgets/chart.dart';
import '../models/transaction.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userExpenses = [
    // Transaction(
    //   id: "t1",
    //   title: "Groceries",
    //   amount: 100.00,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: "Shoes",
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't3',
    //   title: "Food",
    //   amount: 30,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't4',
    //   title: "Dance Class",
    //   amount: 70.00,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't5',
    //   title: "Book",
    //   amount: 50.00,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't6',
    //   title: "Pharmacy",
    //   amount: 40.00,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't7',
    //   title: "Groceries",
    //   amount: 120.0,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;
  int countId = 0;

  List<Transaction> get _recentTransactions {
    return _userExpenses.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTransaction = Transaction(
      id: (countId++).toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );

    setState(() {
      _userExpenses.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewExpense(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userExpenses.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation. landscape;
    //We are saving the appBar in a variable so we can get it's size
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          tooltip: "Add new expense",
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    final txListWidget =  Container(
      //The height of List will be 75% of the result of the substraction: screen size - appbar size - size of system status bar 
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height - MediaQuery.of(context).padding.top) *
          0.75,
      child: ExpensesList(
        list: _userExpenses,
        deleteTx: _deleteTransaction,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandscape) Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(
                    value: _showChart,
                    onChanged: (val){
                      setState((){
                        _showChart = val;
                      });
                    },
                  )
                ],
              ),
              if (!isLandscape) Container(
                //The height of Chart will be 25% of the result of the substraction: screen size - appbar size - size of system status bar 
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height - MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransactions)
              ),
              if (!isLandscape) txListWidget,
              _showChart 
                ? Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height - MediaQuery.of(context).padding.top) *
                      0.7,
                  child: Chart(_recentTransactions)
               ) 
               : txListWidget
             
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: "Add new expense",
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
