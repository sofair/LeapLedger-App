part of 'transaction_category_mapping_bloc.dart';

@immutable
abstract class TransactionCategoryMappingEvent {}

final class TransactionCategoryMappingLoadEvent extends TransactionCategoryMappingEvent {}

final class TransactionCategoryMappingAddEvent extends TransactionCategoryMappingEvent {
  final TransactionCategoryModel parent;
  final BaseTransactionCategoryModel child;
  TransactionCategoryMappingAddEvent(this.parent, this.child);
}

final class TransactionCategoryMappingDeleteEvent extends TransactionCategoryMappingEvent {
  final TransactionCategoryModel parent;
  final BaseTransactionCategoryModel child;
  TransactionCategoryMappingDeleteEvent(this.parent, this.child);
}

final class TransactionCategoryMappingUploadBillEvent extends TransactionCategoryMappingEvent {
  final String filePath;
  TransactionCategoryMappingUploadBillEvent(this.filePath);
}
