part of 'edit_bloc.dart';

@immutable
sealed class EditEvent {}

class EditDataFetch extends EditEvent {
  final AccountModel account;
  EditDataFetch(this.account);
}

class TransactionCategoryFetch extends EditEvent {
  final IncomeExpense type;
  TransactionCategoryFetch(this.type);
}

class AccountChange extends EditEvent {
  final AccountModel account;
  AccountChange(this.account);
}
