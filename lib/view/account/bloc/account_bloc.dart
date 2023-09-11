import 'package:bloc/bloc.dart';
import 'package:keepaccount_app/model/account/account.dart';
import 'package:keepaccount_app/api/api_server.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<AccountSaveEvent>(_mapAccountSaveEventToState);
    on<AccountDeleteEvent>(deleteAccount);
  }

  deleteAccount(AccountDeleteEvent event, Emitter<AccountState> emit) async* {
    if ((await AccountApi.delete(event.accountModel.id)).isSuccess) {
      emit(AccountDeleteSuccessState());
    } else {
      emit(AccountDeleteFailState());
    }
  }

  _mapAccountSaveEventToState(
      AccountSaveEvent event, Emitter<AccountState> emit) {
    getData(event.accountModel);
    if (event.accountModel.id > 0) {
      updateAccount(event, emit);
    } else {
      addAccount(event, emit);
    }
    // Emit a new state to indicate that the save operation is completed.
    //emit(AccountInitial());
  }

  getData(AccountModel accountModel) {
    accountModel.name;
  }

  Stream<AccountState> updateAccount(
      AccountSaveEvent event, Emitter<AccountState> emit) async* {
    if ((await AccountApi.update(event.accountModel)).isSuccess) {
      emit(AccountSaveSuccessState(event.accountModel));
    } else {
      emit(AccountSaveFailState(event.accountModel));
    }
  }

  Stream<AccountState> addAccount(
      AccountSaveEvent event, Emitter<AccountState> emit) async* {
    if ((await AccountApi.add(event.accountModel)).isSuccess) {
      emit(AccountSaveSuccessState(event.accountModel));
    } else {
      emit(AccountSaveFailState(event.accountModel));
    }
  }

  getOne(int id) async {
    await AccountApi.getOne(id);
  }
}
