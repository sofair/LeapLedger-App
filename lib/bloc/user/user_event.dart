part of 'user_bloc.dart';

abstract class UserEvent {}

class UserLoginEvent extends UserEvent {
  final String userAccount, password;
  UserLoginEvent(this.userAccount, this.password);
}

class SetCurrentAccountId extends UserEvent {
  final int accountId;
  SetCurrentAccountId(this.accountId);
}
