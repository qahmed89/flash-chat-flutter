import 'dart:ui';

import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
   RoundedButton( {
    this.colorButton , @required this.labelText , @required this.onPress
  }) ;
  final Color  colorButton ;
  final String labelText ;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: colorButton,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPress
            //Go to registration screen.
           // Navigator.pushNamed(context, RegistrationScreen.id);
          ,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            labelText,
          ),
        ),
      ),
    );
  }
}