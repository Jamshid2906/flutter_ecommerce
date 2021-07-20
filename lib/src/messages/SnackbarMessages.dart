  
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarMessages{
  static void warningSnackbar(BuildContext context, String text){
    ScaffoldMessenger.of(context).showSnackBar( 
      SnackBar(
        backgroundColor: Colors.yellow[400],
        content: Text(text),
        action: SnackBarAction(label: "Cancel",textColor: Colors.white, onPressed: (){}),
      )
    );
  }

  static void successSnackBar(BuildContext context,String text){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green[400],
        content: Text(text),
        action: SnackBarAction(label: "Cancel",textColor: Colors.white, onPressed: (){}),
      )
    );
  }

  static void dangerSnackBar(BuildContext context,String text){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red[400],
        content: Text(text),
        action: SnackBarAction(label: "Cancel", textColor: Colors.white, onPressed: (){}),
      )
    );
  }
  static void primarySnackBar(BuildContext context,String text){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue[400],
        content: Text(text),
        action: SnackBarAction(label: "Cancel", textColor: Colors.white, onPressed: (){}),
      )
    );
  }
}