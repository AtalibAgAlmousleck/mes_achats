// ignore_for_file: use_key_in_widget_constructors, prefer_typing_uninitialized_variables, must_be_immutable, sized_box_for_whitespace, unnecessary_null_comparison, prefer_final_fields
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  var newTransaction;

  NewTransaction(this.newTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  var _titleController = TextEditingController();
  var _amountController = TextEditingController();
  DateTime? _selectDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enterTitle = _titleController.text;
    final enterAmount = double.parse(_amountController.text);
    //write the logic
    if(enterTitle.isEmpty || enterAmount <= 0 || _selectDate == null) {
      return;
    }
    widget.newTransaction(enterTitle, enterAmount, _selectDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2022), 
      lastDate: DateTime.now()).then((pickDate) {
        if (pickDate == null) {
          return;
        }
        setState(() {
          _selectDate = pickDate;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10, left: 10,
            right: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                enableInteractiveSelection: false,
                cursorWidth: 2,
                decoration: InputDecoration(
                  hintText: 'Title',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                enableInteractiveSelection: false,
                cursorWidth: 2,
                decoration: InputDecoration(
                  hintText: 'Amount',
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
               Container(
                 height: 80,
                 child: Row(
                   children: <Widget>[
                     Expanded(
                       child: Text(
                         _selectDate == null ? 'No Date Chosen' 
                         :'Picked Date: ${DateFormat.yMd().format(_selectDate!)}', style: TextStyle(
                         fontFamily: 'OpenSans'
                       ),),
                     ),
                    //AdaptiveFlatButton('Choose Date', _presentDatePicker)
                     Platform.isIOS ?
                    CupertinoButton(
                       onPressed: () => _presentDatePicker(context),
                       child: Text('Choose Datte', style: TextStyle(
                       fontFamily: 'OpenSans'
                     )),
                       color: Theme.of(context).primaryColor,
                       ):
                     // ignore: deprecated_member_use
                     FlatButton(
                       onPressed: () => _presentDatePicker(context),
                       child: Text('Choose Date', style: TextStyle(
                       fontFamily: 'OpenSans'
                     )),
                       textColor: Theme.of(context).primaryColor,
                     ),
                   ]
                 ),
               ),
              // ignore: deprecated_member_use
              RaisedButton(
                child: Text('Transaction', style: TextStyle(color: Colors.white),),
                color: Colors.purple,
                onPressed: _submitData,
              )
            ],
          ),
        ),
        elevation: 5,
      ),
    );
  }
}
