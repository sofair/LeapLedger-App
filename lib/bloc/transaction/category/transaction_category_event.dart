part of 'transaction_category_bloc.dart';

abstract class TransactionCategoryEvent {}

class TransactionCategorySaveEvent extends TransactionCategoryEvent {
  final TransactionCategoryModel transactionCategory;
  TransactionCategorySaveEvent(this.transactionCategory);
}

class TransactionCategoryDeleteEvent extends TransactionCategoryEvent {
  final TransactionCategoryModel transactionCategory;
  TransactionCategoryDeleteEvent(this.transactionCategory);
}
