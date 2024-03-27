import 'package:bloc/bloc.dart';
import 'package:keepaccount_app/api/api_server.dart';
import 'package:keepaccount_app/model/account/model.dart';
import 'package:meta/meta.dart';

part 'account_mapping_state.dart';

class AccountMappingCubit extends Cubit<AccountMappingState> {
  AccountMappingCubit(this.mainAccount, {this.mapping}) : super(AccountMappingInitial());
  final AccountModel mainAccount;
  AccountMappingModel? mapping;
  List<AccountDetailModel> list = [];
  fetchData() async {
    list = await AccountApi.getListByType<AccountDetailModel>(type: AccountType.independent);
    emit(AccountListLoad());
  }

  changeMapping(AccountDetailModel account) async {
    bool isThisMapping = mapping == null || mapping!.relatedAccount.id != account.id;
    if (isThisMapping) {
      var mapping = await AccountApi.changeMapping(mainAccountId: mainAccount.id, relatedAccountId: account.id);
      if (mapping == null) {
        return;
      }
      this.mapping = mapping;
      emit(AccountMappingChanged());
    } else {
      var isSuccess = await AccountApi.deleteMapping(mappingId: mapping!.id);
      if (false == isSuccess) {
        return;
      }
      mapping == null;
      emit(AccountMappingChanged());
    }
  }
}
