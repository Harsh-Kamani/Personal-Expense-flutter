import 'dart:ui';

import 'package:firstapp/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetx;

  TransactionList(this.transactions, this.deletetx);


  @override
  Widget build(BuildContext context) {
    return Container(
         height:MediaQuery.of(context).size.height*0.7,
        child: transactions.isEmpty
            ? Column(
          children: [Image.asset("imges/add.png")],
        )
            : ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child:
                          Text('₹ ${transactions[index].amount}'))),
                ),

                title:Text(
                  transactions[index].title,
                style: Theme
                    .of(context)
                    .textTheme
                    .title,
              ),
              trailing: IconButton(
                color: Colors.red,
                icon: Icon(Icons.delete),
                onPressed: () => deletetx(transactions[index].id),
              ),
              subtitle: Text(DateFormat('dd-MM-yyyy,EEEE')
                  .format(transactions[index].date)),
            ),);
          },
          itemCount: transactions.length,
        ));
  }
}
