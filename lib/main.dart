import 'package:firstapp/new_transaction.dart';
import 'package:firstapp/transaction_list.dart';

//import 'package:firstapp/user_transaction.dart';
import 'package:flutter/cupertino.dart';

// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './transaction.dart';
import './Chart.dart';



void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(primarySwatch: Colors.lime),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> usertransaction = [
    // Transaction(id: "t1", tital: "Watch", amount: 45.67, date: DateTime.now()),
    // Transaction(id: "t1", tital: "Cloth", amount: 45.67, date: DateTime.now())
  ];

  List<Transaction>? get _recentTranasacttion {
    return usertransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void newUserTransaction(String txTitle, double txamount,
      DateTime chosendate) {
    final newtx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txamount,
        date: chosendate);

    setState(() {
      usertransaction.add(newtx);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(newUserTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void deleteTransaction(String id) {
    setState(() {
      usertransaction.removeWhere((tx) => tx.id == id);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text('Personal Expense'),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
              onPressed: () => startAddNewTransaction(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Chart(_recentTranasacttion!),
              TransactionList(usertransaction, deleteTransaction),
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
