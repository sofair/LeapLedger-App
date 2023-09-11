part of 'account_list_bloc.dart';

@immutable
abstract class AccountListState {}

class AccountListInitial extends AccountListState {}

class AccountListLoading extends AccountListState {}

class AccountListLoaded extends AccountListState {
  final List<AccountModel> list;

  AccountListLoaded({required this.list});
}

class AccountListError extends AccountListState {
  final Exception e;
  AccountListError(this.e);
}
