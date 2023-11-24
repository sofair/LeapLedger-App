part of 'transaction_category_mapping_bloc.dart';

@immutable
abstract class TransactionCategoryMappingEvent {}

final class TransactionCategoryMappingLoadEvent extends TransactionCategoryMappingEvent {}

final class TransactionCategoryMappingAddEvent extends TransactionCategoryMappingEvent {
  final TransactionCategoryModel transactionCategory;
  final ProductTransactionCategoryModel productTransactionCategory;
  TransactionCategoryMappingAddEvent(this.transactionCategory, this.productTransactionCategory);
}

final class TransactionCategoryMappingDeleteEvent extends TransactionCategoryMappingEvent {
  final TransactionCategoryModel transactionCategory;
  final ProductTransactionCategoryModel productTransactionCategory;
  TransactionCategoryMappingDeleteEvent(this.transactionCategory, this.productTransactionCategory);
}

final class TransactionCategoryMappingUploadBillEvent extends TransactionCategoryMappingEvent {
  final String filePath;
  TransactionCategoryMappingUploadBillEvent(this.filePath);
}
