part of 'routes.dart';

class AccountRoutes {
  static String baseUrl = 'account';
  static String list = '$baseUrl/list';
  static String edit = '$baseUrl/edit';
  static String detail = '$baseUrl/detail';
  static void init() {
    Routes.routes.addAll({
      list: (context) =>
          Routes.buildloginPermissionRoute(context, const AccountList()),
      edit: (context) => const AccountEdit(),
      detail: (context) => const AccountDetail(),
    });
  }
}
