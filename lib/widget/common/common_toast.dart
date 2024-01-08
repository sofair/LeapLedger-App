part of 'common.dart';

class CommonToast {
  const CommonToast();
  static tipToast(String msg) {
    Fluttertoast.showToast(
        msg: msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 5, fontSize: 16.0);
  }

  static errorToast(String msg) {
    Fluttertoast.showToast(
        msg: msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 5, fontSize: 16.0);
  }
}
