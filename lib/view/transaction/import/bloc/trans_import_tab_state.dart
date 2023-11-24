part of 'enter.dart';

sealed class TransImportTabState {}

final class TransImportTabInitial extends TransImportTabState {}

final class TransImportTabLoaded extends TransImportTabState {
  final List<ProductModel> list;
  final List<MapEntry<TransactionCategoryFatherModel, List<TransactionCategoryModel>>> tree;
  TransImportTabLoaded(this.list, this.tree);
}
