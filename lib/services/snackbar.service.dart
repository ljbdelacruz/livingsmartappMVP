


import 'package:flutter/material.dart';

class SnackBarService{

  static textSnack(GlobalKey<ScaffoldState> scaffoldKey, String message){
    scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(message),
            ),
    );
  }
}