part of 'account_bloc.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountSaveSuccessState extends AccountState {
  final AccountModel accountModel;
  AccountSaveSuccessState(this.accountModel);
}

class AccountSaveFailState extends AccountState {
  final AccountModel accountModel;
  AccountSaveFailState(this.accountModel);
}

class AccountDeleteSuccessState extends AccountState {}

class AccountDeleteFailState extends AccountState {}
