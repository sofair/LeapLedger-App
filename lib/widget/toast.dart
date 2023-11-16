import 'package:fluttertoast/fluttertoast.dart';

tipToast(String msg) {
  Fluttertoast.showToast(
      msg: msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 5, fontSize: 16.0);
}
