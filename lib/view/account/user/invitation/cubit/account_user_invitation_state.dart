part of 'account_user_invitation_cubit.dart';

@immutable
sealed class AccountUserInvitationState {}

final class AccountUserInvitationInitial extends AccountUserInvitationState {}

final class AccountUserInvitationLoaded extends AccountUserInvitationState {
  final List<AccountUserInvitationModle> list;
  AccountUserInvitationLoaded(this.list);
}
