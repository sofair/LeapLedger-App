import 'package:bloc/bloc.dart';
import 'package:keepaccount_app/api/api_server.dart';
import 'package:keepaccount_app/common/global.dart';
import 'package:keepaccount_app/model/account/model.dart';
import 'package:keepaccount_app/model/transaction/category/model.dart';
import 'package:meta/meta.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  EditBloc(this.account) : super(EditInitial()) {
    on<EditDataFetch>(_fetchData);
    on<TransactionCategoryFetch>(_fetchTransactionCategory);
    on<AccountChange>(_changeAccount);
  }
  AccountModel account;
  _fetchData(EditDataFetch event, emit) async {}

  _fetchTransactionCategory(TransactionCategoryFetch event, emit) async {
    List<TransactionCategoryModel> list;
    list = await ApiServer.getData(
      () => TransactionCategoryApi.getTree(type: event.type),
      TransactionCategoryApi.dataFormatFunc.getCategoryListByTree,
    );
    if (event.type == IncomeExpense.expense) {
      emit(ExpenseCategoryPickLoaded(list));
    } else {
      emit(IncomeCategoryPickLoaded(list));
    }
  }

  _changeAccount(AccountChange event, emit) {
    if (account.id == event.account.id) {
      return;
    }
    account.copyWith(event.account);
    emit(AccountChanged(account));
  }
}
