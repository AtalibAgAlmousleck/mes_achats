// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mes_achats/model/transaction.dart';

class TransactionItem extends StatelessWidget {

  final Transaction transaction;
  var deleteTransaction;

  TransactionItem({ Key? key,
      required this.transaction,
      required this.deleteTransaction
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
                  elevation: 8,
                  margin: EdgeInsets.symmetric(
                    vertical: 8, horizontal: 5
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: Text('\$${transaction.amount}')),
                      ),
                    ),
                    title: Text(transaction.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Text(
                      //DateFormat.yMd().add_jm().format
                      DateFormat.yMd().format(transaction.date),
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460 ?
                    // ignore: deprecated_member_use
                    FlatButton.icon(
                      onPressed: () => deleteTransaction(transaction.id),
                      icon: Icon(Icons.delete),
                      label: Text('Delete'),
                      textColor: Theme.of(context).errorColor,
                    )
                    : IconButton(
                      onPressed: () => deleteTransaction(transaction.id),
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                    ),
                  ),  
                );
  }
}