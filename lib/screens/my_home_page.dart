// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, must_be_immutable, avoid_print, prefer_final_fields, sized_box_for_whitespace
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/chart.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';

import '../model/transaction.dart';

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //add new transaction
   List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: 'Java Book', amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'Flutter Book', amount: 86.99, date: DateTime.now()),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      title: title, amount: amount, 
      date: chosenDate, id: DateTime.now().toString());
      setState(() {
        _userTransactions.add(newTx);
      });
  }

  //call fot the showModalBottomSheet
  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
      setState(() {
        _userTransactions.removeWhere((transaction) {
          return transaction.id == id;
        });
      });
  }

  Widget _buildLandscapeContent() {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show Chart',
                style: Theme.of(context).textTheme.bodyText1,
                ),
                Switch.adaptive(
                  value: _showChart, 
                 onChanged: (value) {
                   setState(() {
                     _showChart = value;
                   });
                 }
                )
              ],
            );
  }

  Widget _buildAppBar() {
    return (
      Platform.isIOS ? 
    CupertinoNavigationBar(
      middle: Text('Expense Expenses'),
      trailing: Row(mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          )
        ],
      ),
    ) : AppBar(
        title: Text('Expense Manager'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add, size: 30,),
          ),
        ],
      )
    ) as PreferredSizeWidget;
  }

  Widget _buildPortraiteContent(MediaQueryData mediaQuery, AppBar appBar) {
    return Container(
              height: (mediaQuery.size.height
                       - appBar.preferredSize.height 
                       - mediaQuery.padding.top) * 0.3,
              child: Chart(_recentTransactions),
            );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation
                      == Orientation.landscape;

    //ObstructingPreferredSizeWidget?
    final PreferredSizeWidget appBar = _buildAppBar() as PreferredSizeWidget;
      final txListWidget = Container(
              height: (mediaQuery.size.height
                       - appBar.preferredSize.height
                       - mediaQuery.padding.top) * 0.7,
              child: TransactionList(_userTransactions, _deleteTransaction),
            );
    final pageHome = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[ 
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15)
            //   ),
            //   height: 100,
            //   width: double.infinity,
            //   child: Card(
            //     color: Colors.pink,
            //     child: Text(
            //       'CHART!',
            //       textAlign: TextAlign.center,
            //     ),
            //     elevation: 5,
            //   ),
            // ),
            //UserTransaction(),
          if(isLandscape) _buildLandscapeContent(),
            if(!isLandscape) 
            _buildPortraiteContent(mediaQuery, appBar as AppBar),
            if(!isLandscape) txListWidget,

            if(isLandscape) _showChart ? Container(
              height: (mediaQuery.size.height
                       - appBar.preferredSize.height 
                       - mediaQuery.padding.top) * 0.7,
              child: Chart(_recentTransactions),
            ) :
            txListWidget
          ],
        ),
      ));
    return Platform.isIOS ? CupertinoPageScaffold(
      child: pageHome,
      navigationBar: appBar as ObstructingPreferredSizeWidget,
    ) : Scaffold(
      appBar: appBar,
      body: pageHome,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.navigation),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
