import 'package:flutter/material.dart';
import 'package:keepaccount_app/model/transaction/category/model.dart';
import 'package:keepaccount_app/view/account/detail/account_detail.dart';

import 'package:keepaccount_app/view/account/edit/account_edit.dart';

import 'package:keepaccount_app/view/account/list/account_list.dart';
import 'package:keepaccount_app/view/login/login.dart';
import 'package:keepaccount_app/view/transaction/category/edit/transaction_category_edit.dart';
import 'package:keepaccount_app/view/transaction/category/father/edit/transaction_category_father_edit.dart';
import 'package:keepaccount_app/view/transaction/category/tree/transaction_category_tree.dart';
import 'package:keepaccount_app/view/transaction/import/transaction_import.dart';

part "animation.dart";
part 'account_routes.dart';
part 'transaction_category_routes.dart';
part 'transaction_import_routes.dart';

class Routes {
  static const String home = 'home';
  static const String login = 'login';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return LeftSlideRoute(page: const Login());
      default:
        return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: Center(child: Text('Route not found'))));
    }
  }

  static Map<String, WidgetBuilder> routes = {};
  static void init() {
    AccountRoutes.init();
    TransactionCategoryRoutes.init();
    TransactionImportRoutes.init();
    print(routes);
  }

  static Widget buildloginPermissionRoute(BuildContext context, Widget widget) {
    return widget;
  }

  static T? argument<T>(BuildContext context, String key) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is Map<String, dynamic> && args.containsKey(key)) {
      return args[key] as T?;
    }
    return null;
  }
}
