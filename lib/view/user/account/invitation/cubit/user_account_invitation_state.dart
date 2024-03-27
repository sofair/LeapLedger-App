part of 'user_account_invitation_cubit.dart';

@immutable
sealed class UserAccountInvitationState {}

final class UserAccountInvitationInitial extends UserAccountInvitationState {}

final class UserAccountInvitationLoaded extends UserAccountInvitationState {
  final List<AccountUserInvitationModle> list;
  UserAccountInvitationLoaded(this.list);
}

final class UserAccountInvitationUpdated extends UserAccountInvitationState {
  final AccountUserInvitationModle item;
  UserAccountInvitationUpdated(this.item);
}
