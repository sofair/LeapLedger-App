part of 'routes.dart';

class UserRoutes {
  static const String baseUrl = 'user';
  static const String home = '$baseUrl/home';
  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String forgetPassword = '$baseUrl/forgetPassword';
  static const String passwordUpdate = '$baseUrl/password/update';
  static const String search = '$baseUrl/search';
  static const String configTransactionShare = '$baseUrl/config/transaction/share';
  static const String accountInvitation = '$baseUrl/account/invitation';
  static void init() {
    Routes.routes.addAll({
      forgetPassword: (context) => const UserForgetPassword(),
      passwordUpdate: (context) => const UserPasswordUpdate(),
      search: (context) => const UserSearch(),
      configTransactionShare: (context) => const UserConfigTransactionShare(),
      accountInvitation: (context) => const UserAccountInvitation(),
    });
  }

  static Future<T?> pushNamed<T extends Object?>(BuildContext context, String routeName, {Object? arguments}) {
    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<UserInfoModel?> pushSearch(BuildContext context) async {
    UserInfoModel? result;
    await Navigator.of(context).pushNamed(search).then((value) {
      if (value is UserInfoModel) {
        result = value;
      }
    });
    return result;
  }
}
