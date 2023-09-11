part of 'transaction_category_bloc.dart';

abstract class TransactionCategoryState {}

class TransactionCategoryInitial extends TransactionCategoryState {}

class SaveSuccessState extends TransactionCategoryState {
  final TransactionCategoryModel transactionCategory;
  SaveSuccessState(this.transactionCategory);
}

class SaveFailState extends TransactionCategoryState {
  final TransactionCategoryModel transactionCategory;
  SaveFailState(this.transactionCategory);
}

class DeleteSuccessState extends TransactionCategoryState {}

class DeleteFailState extends TransactionCategoryState {}
