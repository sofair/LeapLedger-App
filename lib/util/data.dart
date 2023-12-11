part of 'enter.dart';

class Data {
  static int? stringToInt(String? value) {
    if (value != null && value.isNotEmpty) {
      return int.parse(value);
    }
    return null;
  }

  static String? intToString(int? value) {
    if (value != null) {
      return value.toString();
    }
    return null;
  }

  static double? stringToDouble(String? value) {
    if (value != null && value.isNotEmpty) {
      return double.parse(value);
    }
    return null;
  }

  static String? doubleToString(double? value) {
    if (value != null) {
      return value.toString();
    }
    return null;
  }
}
