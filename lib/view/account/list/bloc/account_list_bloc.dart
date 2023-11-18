import 'package:bloc/bloc.dart';
import 'package:keepaccount_app/api/api_server.dart';
import 'package:flutter/cupertino.dart';
import 'package:keepaccount_app/model/account/model.dart';

part 'account_list_event.dart';
part 'account_list_state.dart';

class AccountListBloc extends Bloc<AccountListEvent, AccountListState> {
  late List<AccountModel> _list;

  AccountListBloc() : super(AccountListLoading()) {
    _list = [];
    on<GetListEvent>(_getList);
    on<RefreshEvent>(_refreshList);
  }

  _getList(GetListEvent event, Emitter<AccountListState> emit) async {
    _list = await AccountApi.getList();
    emit(AccountListLoaded(list: _list));
  }

  _refreshList(RefreshEvent event, Emitter<AccountListState> emit) async {
    _list = await AccountApi.getList();
    emit(AccountListLoaded(list: _list));
  }
}
