part of 'transaction_import_bloc.dart';

@immutable
abstract class TransactionImportState {}

class TransactionImportInitial extends TransactionImportState {}

class LoadingState extends TransactionImportState {}

class TransactionImportLoadedState extends TransactionImportState {
  final List<ProductTransactionCategoryModel> unmapped;
  final Map<int, List<ProductTransactionCategoryModel>> relation;
  TransactionImportLoadedState(this.unmapped, this.relation);
}

class IdName {
  int id;
  String name;
  IdName(this.id, this.name);
}
