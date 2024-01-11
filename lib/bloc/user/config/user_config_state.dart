part of 'user_config_bloc.dart';

@immutable
sealed class UserConfigState {}

final class UserConfigInitial extends UserConfigState {}

final class UserTransactionShareConfigLoaded extends UserConfigState {
  final UserTransactionShareConfigModel config;
  UserTransactionShareConfigLoaded(this.config);
}

final class UserTransactionShareConfigUpdateSuccess extends UserConfigState {
  final UserTransactionShareConfigModel config;
  UserTransactionShareConfigUpdateSuccess(this.config);
}
