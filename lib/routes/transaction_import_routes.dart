part of 'routes.dart';

class TransactionImportRoutes {
  static const String _base = 'transactionImport';
  static String home = '$_base/home';

  static void init() {
    Routes.routes[home] = (context) => const TransactionImport();
  }
}
