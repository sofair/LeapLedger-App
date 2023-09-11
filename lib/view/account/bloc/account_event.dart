part of 'account_bloc.dart';

abstract class AccountEvent {}

class AccountInitialEvent extends AccountEvent {
  final int id;
  AccountInitialEvent(this.id);
}

class AccountSaveEvent extends AccountEvent {
  final AccountModel accountModel;
  AccountSaveEvent(this.accountModel);
}

class AccountDeleteEvent extends AccountEvent {
  final AccountModel accountModel;
  AccountDeleteEvent(this.accountModel);
}
