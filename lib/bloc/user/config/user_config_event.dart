part of 'user_config_bloc.dart';

@immutable
sealed class UserConfigEvent {}

/* 交易分享配置 */
class UserTransactionShareConfigFetch extends UserConfigEvent {
  UserTransactionShareConfigFetch();
}

class UserTransactionShareConfigUpdate extends UserConfigEvent {
  final UserTransactionShareConfigFlag flag;
  final bool status;
  UserTransactionShareConfigUpdate(this.flag, this.status);
}
