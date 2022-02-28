// ignore_for_file: unused_field, prefer_final_fields, must_be_immutable, use_key_in_widget_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:mes_achats/model/transaction.dart';
import 'package:mes_achats/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;
  var deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
          ? LayoutBuilder(builder: (context, constraintes) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You don\'t hava transaction yet!',
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: constraintes.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          }) 
          : ListView.builder(
              itemBuilder: (context, index) {
                return TransactionItem(
                  transaction: transactions[index], 
                  deleteTransaction: deleteTransaction,
                );
              },
              itemCount: transactions.length,
    );
  }
}
