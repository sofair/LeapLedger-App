part of 'routes.dart';

class TransactionRoutes {
  static void init() {}
  static TransactionEditNavigator editNavigator(BuildContext context,
      {required TransactionEditMode mode, required AccountDetailModel account, TransactionModel? transaction}) {
    return TransactionEditNavigator(context, mode: mode, transaction: transaction, account: account);
  }

  static pushFlow(
    BuildContext context, {
    TransactionQueryConditionApiModel? condition,
    AccountDetailModel? account,
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
      {required AccountDetailModel account, TransactionModel? transaction, int? transactionId}) {
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

  /// 已弃用 新方法[TransactionRoutes.editNavigator]
  @Deprecated('Use [TransactionRoutes.editNavigator] instead')
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
}

class TransactionRouterGuard {
  /// [TransactionEditNavigator]的鉴权方法
  static bool edit(
      {required TransactionEditMode mode, required AccountDetailModel account, TransactionModel? transaction}) {
    if (transaction != null) {
      if (transaction.accountId != account.id) {
        return false;
      }
    }
    if (account.isReader) {
      return false;
    }
    return true;
  }
}

class TransactionEditNavigator extends RouterNavigator {
  final TransactionEditMode mode;
  final TransactionModel? transaction;
  final AccountDetailModel account;
  TransactionEditNavigator(BuildContext context, {required this.account, required this.mode, this.transaction})
      : super(context: context);

  @override
  bool get guard => TransactionRouterGuard.edit(mode: mode, transaction: transaction, account: account);
  Future<bool> push() async {
    return await _leftSlidePush(context, TransactionEdit(mode: mode, model: transaction, account: account));
  }

  @override
  _then(value) {
    isFinish = value is bool ? value : false;
  }

  bool isFinish = false;
  bool getReturn() {
    return isFinish;
  }
}
