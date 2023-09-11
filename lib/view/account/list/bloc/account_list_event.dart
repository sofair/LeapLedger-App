part of 'account_list_bloc.dart';

@immutable
abstract class AccountListEvent {}

class GetListEvent extends AccountListEvent {}

class ClickMoreEvent extends AccountListEvent {
  final int clickAccountIndex;
  ClickMoreEvent(this.clickAccountIndex);
}

class RefreshEvent extends AccountListEvent {}
