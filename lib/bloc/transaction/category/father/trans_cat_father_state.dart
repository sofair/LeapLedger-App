part of 'trans_cat_father_bloc.dart';

abstract class TransCatFatherState {}

class TransCatFatherInitial extends TransCatFatherState {}

class SaveSuccessState extends TransCatFatherState {
  final TransactionCategoryFatherModel transactionCategoryFather;
  SaveSuccessState(this.transactionCategoryFather);
}

class SaveFailState extends TransCatFatherState {
  final TransactionCategoryFatherModel transactionCategoryFather;
  SaveFailState(this.transactionCategoryFather);
}

class DeleteSuccessState extends TransCatFatherState {}

class DeleteFailState extends TransCatFatherState {}
