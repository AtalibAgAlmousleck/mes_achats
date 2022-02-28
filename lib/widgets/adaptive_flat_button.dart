// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AdaptiveFlatButton extends StatelessWidget {
  
  final String text;
  final String seleted;

  AdaptiveFlatButton(this.text, this.seleted);

  @override
  Widget build(BuildContext context) {
    return  // ignore: deprecated_member_use
                    Platform.isIOS ?
                    CupertinoButton(
                       onPressed: () => seleted,
                       child: Text(text, style: TextStyle(
                       fontFamily: 'OpenSans'
                     )),
                       color: Theme.of(context).primaryColor,
                       ):
                     // ignore: deprecated_member_use
                     FlatButton(
                       onPressed: () => seleted,
                       child: Text(text, style: TextStyle(
                       fontFamily: 'OpenSans'
                     )),
                       textColor: Theme.of(context).primaryColor,
                     );
  }
}