part of 'edit_bloc.dart';

@immutable
sealed class EditState {}

final class EditInitial extends EditState {}

final class ExpenseCategoryPickLoaded extends EditState {
  final List<TransactionCategoryModel> tree;
  ExpenseCategoryPickLoaded(this.tree);
}

final class IncomeCategoryPickLoaded extends EditState {
  final List<TransactionCategoryModel> tree;
  IncomeCategoryPickLoaded(this.tree);
}

final class AccountChanged extends EditState {
  final AccountModel account;
  AccountChanged(this.account);
}
