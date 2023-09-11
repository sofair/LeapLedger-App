part of 'transaction_category_tree_bloc.dart';

abstract class TransactionCategoryTreeState {}

class TransactionCategoryInitial extends TransactionCategoryTreeState {}

class LoadingState extends TransactionCategoryTreeState {}

class LoadedState extends TransactionCategoryTreeState {
  List<CategoryData> list;
  LoadedState(this.list);
}
