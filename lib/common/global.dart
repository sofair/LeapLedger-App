import 'package:flutter/material.dart';
import 'package:keepaccount_app/config/config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:keepaccount_app/util/enter.dart';

class Global {
  static SharedPreferencesCache cache = SharedPreferencesCache();

  static Config config = Config();
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<OverlayState> overlayKey = GlobalKey<OverlayState>();
  static OverlayEntry? overlayEntry;
  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    config.init();
  }

  static void showOverlayLoader() {
    EasyLoading.show(status: 'Loading...');
  }

  static void hideOverlayLoader() {
    EasyLoading.dismiss(); // Hide the loading indicator
  }

  static bool isShowOverlayLoader() {
    return EasyLoading.isShow; // Hide the loading indicator
  }
}

enum IncomeExpense { income, expense }

// ignore: constant_identifier_names
const INCOME = "income", EXPENSE = "expense";

enum UserAction { register, updatePassword, forgetPassword }
