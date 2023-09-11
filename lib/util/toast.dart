import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as fluttertoast;

class Toast {
  error({required String message}) {
    fluttertoast.Fluttertoast.showToast(
        msg: message,
        toastLength: fluttertoast.Toast.LENGTH_SHORT,
        gravity: fluttertoast.ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
