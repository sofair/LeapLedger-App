part of 'routes.dart';

class TransactionRoutes {
  static void init() {}

  static pushFlow(
    BuildContext context, {
    TransactionQueryConditionApiModel? condition,
    AccountModel? account,
  }) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransactionFlow(
            condition: condition,
            account: account,
          ),
        ));
  }
}
