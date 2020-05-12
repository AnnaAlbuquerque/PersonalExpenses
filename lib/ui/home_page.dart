import 'dart:io';

import 'package:expense_planner/ui/widgets/expenses_list.dart';
import 'package:expense_planner/ui/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './widgets/new_expense.dart';
import './widgets/chart.dart';
import '../models/transaction.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userExpenses = [
    Transaction(
      id: "t1",
      title: "Groceries",
      amount: 100.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: "Shoes",
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: "Food",
      amount: 30,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: "Dance Class",
      amount: 70.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: "Book",
      amount: 50.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: "Pharmacy",
      amount: 40.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: "Groceries",
      amount: 120.0,
      date: DateTime.now(),
    ),
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
    //It's better to store the media query of  in a variable so it won't create a new object everytime that we use it.
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    /*
      We are saving the appBar in a variable so we can get it's size
      It will manage if it is done on Android (material) or iOS (Cupertino)
    */
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //There isn't a Cupertino Icon Button, so we will do our own button
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                tooltip: "Add new expense",
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );

    final txListWidget = Container(
      //The height of List will be 75% of the result of the substraction: screen size - appbar size - size of system status bar
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.75,
      child: ExpensesList(
        list: _userExpenses,
        deleteTx: _deleteTransaction,
      ),
    );

    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ],
              ),
            if (!isLandscape)
              Container(
                  //The height of Chart will be 25% of the result of the substraction: screen size - appbar size - size of system status bar
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
                  child: Chart(_recentTransactions)),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransactions))
                  : txListWidget
          ]),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    tooltip: "Add new expense",
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
