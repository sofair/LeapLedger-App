part of 'transaction_import_bloc.dart';

@immutable
abstract class TransactionImportEvent {}

final class TransactionImportLoadEvent extends TransactionImportEvent {}

final class TransactionImportMappingEvent extends TransactionImportEvent {
  final TransactionCategoryModel transactionCategory;
  final ProductTransactionCategoryModel productTransactionCategory;
  TransactionImportMappingEvent(this.transactionCategory, this.productTransactionCategory);
}

final class TransactionImportUploadBillEvent extends TransactionImportEvent {
  final String filePath;
  TransactionImportUploadBillEvent(this.filePath);
}
