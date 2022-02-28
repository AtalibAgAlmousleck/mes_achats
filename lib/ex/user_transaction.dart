// ignore_for_file: unused_field, prefer_final_fields, unused_element

// import 'package:flutter/material.dart';
// import 'new_transaction.dart';
// import 'transaction_list.dart';

// class UserTransaction extends StatefulWidget {
//   const UserTransaction({Key? key}) : super(key: key);

//   @override
//   _UserTransactionState createState() => _UserTransactionState();
// }

// class _UserTransactionState extends State<UserTransaction> {
 
//   @override 
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         NewTransaction(_addNewTransaction),
//         TransactionList(_userTransactions),
//       ],
//     );
//   }
// }


//  return Card(
//               child: Row(
//                 children: <Widget>[
//                   Container(
//                     margin: EdgeInsets.symmetric(
//                       vertical: 10,
//                       horizontal: 15,
//                     ),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.purple,
//                         width: 2,
//                       ),
//                     ),
//                     padding: EdgeInsets.all(10),
//                     child: Text(
//                       '\$${transactions[index].amount.toStringAsFixed(2)}',
//                       style: TextStyle(
//                         color: Theme.of(context).primaryColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         transactions[index].title,
//                         style: TextStyle(
//                           fontSize: 16, 
//                           fontWeight: 
//                           FontWeight.bold,
//                       ),
//                       ),
//                       Text(
//                         DateFormat.yMd().add_jm().format(transactions[index].date),
//                         style: TextStyle(color: Colors.grey, fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );