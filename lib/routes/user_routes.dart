part of 'routes.dart';

class UserRoutes {
  static const String baseUrl = 'user';
  static const String home = '$baseUrl/home';
  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String forgetPassword = '$baseUrl/forgetPassword';
  static const String passwordUpdate = '$baseUrl/password/update';
  static const String configTransactionShare = '$baseUrl/config/transaction/share';
  static void init() {
    Routes.routes.addAll({
      forgetPassword: (context) => const UserForgetPassword(),
      passwordUpdate: (context) => const UserPasswordUpdate(),
      configTransactionShare: (context) => const UserConfigTransactionShare(),
    });
  }
}
