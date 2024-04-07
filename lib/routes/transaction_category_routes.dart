part of 'routes.dart';

class TransactionCategoryRoutes {
  static const String _base = 'transactionCategory';
  static String edit = '$_base/edit';
  static String mapping = '$_base/mapping';
  static void init() {
    Routes.routes[edit] = (context) => TransactionCategoryEdit(
        transactionCategory: Routes.argument<TransactionCategoryModel>(context, 'transactionCategory'));
    Routes.routes[mapping] = (context) {
      var product = Routes.argument<ProductModel>(context, 'product');
      var categoryTree =
          Routes.argument<List<MapEntry<TransactionCategoryFatherModel, List<TransactionCategoryModel>>>>(
              context, 'categoryTree');
      var ptcList = Routes.argument<List<ProductTransactionCategoryModel>>(context, 'ptcList');
      if (product == null || categoryTree == null) {
        return Routes.errorWight("product和categoryTree必填");
      }
      return TransactionCategoryMapping(
        product,
        categoryTree,
        ptcList: ptcList,
      );
    };
  }

  @Deprecated("改用global下的NoData.categoryText")
  static RichText getNoDataRichText(BuildContext context) {
    return RichText(
      textScaler: MediaQuery.of(context).textScaler,
      textAlign: TextAlign.center,
      text: const TextSpan(
        children: [
          TextSpan(
              text: '交易类型未设置!\n\n',
              style: TextStyle(
                color: Colors.black,
              )),
        ],
      ),
    );
  }

  static getMappingPushArguments(
    ProductModel product,
    List<MapEntry<TransactionCategoryFatherModel, List<TransactionCategoryModel>>> categoryTree, {
    List<ProductTransactionCategoryModel>? ptcList,
  }) {
    return {'product': product, 'categoryTree': categoryTree, 'ptcList': ptcList};
  }

  static Route<TransactionCategoryTemplate> getTemplateRoute(BuildContext context, {required AccountModel account}) {
    return MaterialPageRoute(
      builder: (context) => TransactionCategoryTemplate(
        account: account,
      ),
    );
  }

  static TransactionCategoryFatherEditNavigator fatherEditNavigator(BuildContext context,
      {required AccountDetailModel account, required TransactionCategoryFatherModel father}) {
    return TransactionCategoryFatherEditNavigator(context, father: father, account: account);
  }

  static TransactionCategorySettingNavigator setting(BuildContext context, {required AccountDetailModel account}) {
    return TransactionCategorySettingNavigator(context, account: account);
  }
}

class TransactionCategoryRouterGuard {
  /// [TransactionCategoryFatherEditNavigator]的鉴权方法
  static bool edit({required AccountDetailModel account}) {
    return account.isCreator;
  }
}

class TransactionCategoryFatherEditNavigator extends RouterNavigator {
  final AccountDetailModel account;
  final TransactionCategoryFatherModel father;
  TransactionCategoryFatherEditNavigator(BuildContext context, {required this.account, required this.father})
      : super(context: context);

  @override
  bool get guard => TransactionCategoryRouterGuard.edit(account: account);
  Future<bool> showDialog() async {
    return await _showDialog(context, TransactionCategoryFatherEditDialog(account: account, model: father));
  }

  @override
  _then(value) {
    result = value is TransactionCategoryFatherModel && value.isValid ? value : null;
  }

  TransactionCategoryFatherModel? result;
  TransactionCategoryFatherModel? getReturn() {
    return result;
  }
}

class TransactionCategorySettingNavigator extends RouterNavigator {
  final AccountDetailModel account;
  TransactionCategorySettingNavigator(BuildContext context, {required this.account}) : super(context: context);

  @override
  bool get guard => true;
  Future<bool> pushTree() async {
    return await _push(context, TransactionCategoryTree(account: account));
  }
}
