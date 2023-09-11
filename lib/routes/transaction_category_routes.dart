part of 'routes.dart';

class TransactionCategoryRoutes {
  static const String _base = 'transactionCategory';
  static String setting = '$_base/setting';
  static String edit = '$_base/edit';
  static String fatherEdit = '$_base/father/edit';
  static void init() {
    Routes.routes[setting] = (context) => const TransactionCategoryTree();
    Routes.routes[edit] = (context) => TransactionCategoryEdit(
        transactionCategory: Routes.argument<TransactionCategoryModel>(
            context, 'transactionCategory'));
    Routes.routes[fatherEdit] = (context) => TransactionCategoryFatherEdit(
        Routes.argument<TransactionCategoryFatherModel>(
            context, 'transactionCategoryFather'));
  }
}
