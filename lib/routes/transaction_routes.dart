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

  static pushDetailBottomSheet(BuildContext context,
      {required AccountModel account, TransactionModel? transaction, int? transactionId}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => TransactionBloc(),
        child: TransactionDetailBottomSheet(
          account: account,
          transaction: transaction,
          transactionId: transactionId,
        ),
      ),
    );
  }

  static void showShareDialog(BuildContext context, {required TransactionShareModel shareModel}) {
    showDialog(
      context: context,
      builder: (context) => TransactionShareDialog(
        data: shareModel,
      ),
    );
  }

  static Future<bool> pushEdit(BuildContext context,
      {required TransactionEditMode mode, TransactionModel? transaction, AccountModel? account}) async {
    bool isFinish = false;
    await Navigator.push(
      context,
      LeftSlideRoute(
        page: TransactionEdit(mode: mode, model: transaction, account: account),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    ).then((value) => value is bool ? isFinish = value : isFinish = false);
    return isFinish;
  }

  static RichText getNoDataRichText(BuildContext context) {
    return RichText(
      textScaler: MediaQuery.of(context).textScaler,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          const TextSpan(
              text: '没有收支记录，快去',
              style: TextStyle(
                color: Colors.black,
              )),
          TextSpan(
              text: '记一笔',
              style: const TextStyle(
                color: Colors.blue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  TransactionRoutes.pushEdit(context, mode: TransactionEditMode.add);
                }),
          const TextSpan(
              text: '吧！',
              style: TextStyle(
                color: Colors.black,
              )),
        ],
      ),
    );
  }
}
