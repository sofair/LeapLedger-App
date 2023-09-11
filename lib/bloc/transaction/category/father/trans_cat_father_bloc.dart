import 'package:bloc/bloc.dart';
import 'package:keepaccount_app/api/api_server.dart';
import 'package:keepaccount_app/bloc/user/user_bloc.dart';
import 'package:keepaccount_app/model/transaction/category/model.dart';

part 'trans_cat_father_event.dart';
part 'trans_cat_father_state.dart';

class TransCatFatherBloc
    extends Bloc<TransCatFatherEvent, TransCatFatherState> {
  TransCatFatherBloc() : super(TransCatFatherInitial()) {
    on<TransCatFatherSaveEvent>(save);
    on<TransCatFatherDeleteEvent>(delete);
  }
  save(TransCatFatherSaveEvent event, Emitter<TransCatFatherState> emit) async {
    ResponseBody responseBody;
    if (event.transactionCategoryFather.id > 0) {
      responseBody = await TransactionCategoryApi.updateCategoryFather(
          event.transactionCategoryFather);
    } else {
      event.transactionCategoryFather.accountId = UserBloc.currentAccount.id;
      responseBody = await TransactionCategoryApi.addCategoryFather(
          event.transactionCategoryFather);
      if (responseBody.isSuccess) {
        event.transactionCategoryFather.id = responseBody.data['Id'];
      }
    }
    if (responseBody.isSuccess) {
      emit(SaveSuccessState(event.transactionCategoryFather));
    } else {
      emit(SaveFailState(event.transactionCategoryFather));
    }
  }

  delete(TransCatFatherDeleteEvent event,
      Emitter<TransCatFatherState> emit) async {
    if ((await TransactionCategoryApi.deleteCategoryChild(
            event.transactionCategoryFather.id))
        .isSuccess) {
      emit(DeleteSuccessState());
    } else {
      emit(DeleteFailState());
    }
  }
}
