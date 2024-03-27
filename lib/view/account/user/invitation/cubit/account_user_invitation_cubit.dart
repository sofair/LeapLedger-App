import 'package:bloc/bloc.dart';
import 'package:keepaccount_app/api/api_server.dart';
import 'package:keepaccount_app/model/account/model.dart';
import 'package:meta/meta.dart';

part 'account_user_invitation_state.dart';

class AccountUserInvitationCubit extends Cubit<AccountUserInvitationState> {
  AccountUserInvitationCubit(this.account) : super(AccountUserInvitationInitial());
  final AccountModel account;
  Future<void> fetchData(int limit, int offset) async {
    List<AccountUserInvitationModle> list;
    list = await AccountApi.getUserInvitation(limit: limit, offset: offset, accountId: account.id);
    emit(AccountUserInvitationLoaded(list));
  }
}
