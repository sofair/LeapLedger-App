import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ErrorAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text("error"),
      content: Text("发生了一个错误，请稍后重试！"),
    );
  }
}

void ErrorToast(BuildContext context, String message, Duration duration) {
  print(message);
  Fluttertoast.showToast(
      msg: "你今天真好看",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16.0);
}
