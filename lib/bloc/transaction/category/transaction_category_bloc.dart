import 'package:bloc/bloc.dart';
import 'package:keepaccount_app/api/api_server.dart';
import 'package:keepaccount_app/model/transaction/category/model.dart';

part 'transaction_category_event.dart';
part 'transaction_category_state.dart';

class TransactionCategoryBloc
    extends Bloc<TransactionCategoryEvent, TransactionCategoryState> {
  TransactionCategoryBloc() : super(TransactionCategoryInitial()) {
    on<TransactionCategorySaveEvent>(save);
    on<TransactionCategoryDeleteEvent>(delete);
  }
  save(TransactionCategorySaveEvent event,
      Emitter<TransactionCategoryState> emit) async {
    ResponseBody responseBody;
    if (event.transactionCategory.id > 0) {
      responseBody = await TransactionCategoryApi.updateCategoryChild(
          event.transactionCategory);
    } else {
      responseBody = await TransactionCategoryApi.addCategoryChild(
          event.transactionCategory);
      if (responseBody.isSuccess) {
        event.transactionCategory.id = responseBody.data['Id'];
      }
    }
    if (responseBody.isSuccess) {
      emit(SaveSuccessState(event.transactionCategory));
    } else {
      emit(SaveFailState(event.transactionCategory));
    }
  }

  delete(TransactionCategoryDeleteEvent event,
      Emitter<TransactionCategoryState> emit) async {
    if ((await TransactionCategoryApi.deleteCategoryChild(
            event.transactionCategory.id))
        .isSuccess) {
      emit(DeleteSuccessState());
    } else {
      emit(DeleteFailState());
    }
  }
}
