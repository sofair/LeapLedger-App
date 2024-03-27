part of 'share_home_bloc.dart';

@immutable
sealed class ShareHomeEvent {}

class LoadAccountListEvent extends ShareHomeEvent {
  LoadAccountListEvent();
}

class LoadShareHomeEvent extends ShareHomeEvent {
  final AccountDetailModel? account;
  LoadShareHomeEvent({this.account});
}

class ChangeAccountEvent extends ShareHomeEvent {
  final AccountDetailModel account;
  ChangeAccountEvent(this.account);
}
