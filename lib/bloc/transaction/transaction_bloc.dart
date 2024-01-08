import 'package:bloc/bloc.dart';
import 'package:keepaccount_app/api/api_server.dart';
import 'package:keepaccount_app/common/global.dart';
import 'package:keepaccount_app/model/account/model.dart';
import 'package:keepaccount_app/model/transaction/model.dart';
import 'package:keepaccount_app/widget/common/common.dart';
import 'package:meta/meta.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<TransactionAdd>(_handleAdd);
    on<TransactionUpdate>(_handleUpdate);
    on<TransactionDelete>(_handleDelete);
  }
  _handleAdd(TransactionAdd event, emit) async {
    var editModel = event.editModel;
    if (false == _verificationData(editModel, emit)) {
      return;
    }
    var trans = await TransactionApi.add(editModel);
    if (trans == null) {
      return;
    }
    emit(TransactionAddSuccess(trans));
    _handleStatisticUpdate(emit, newTrans: trans.editModel);
  }

  _handleUpdate(TransactionUpdate event, emit) async {
    assert(event.editModel.id != 0);
    if (event.editModel.id == 0) {
      return;
    }
    var editModel = event.editModel;
    if (false == _verificationData(editModel, emit)) {
      return;
    }
    TransactionModel? newTrans = await TransactionApi.update(editModel);
    if (newTrans == null) {
      return;
    }
    CommonToast.tipToast("编辑成功");
    emit(TransactionUpdateSuccess(event.oldTrans, newTrans));
    _handleStatisticUpdate(emit, oldTrans: event.oldTrans.editModel, newTrans: newTrans.editModel);
  }

  _handleDelete(TransactionDelete event, emit) async {
    assert(event.trans.id != 0);
    if (event.trans.id == 0) {
      return;
    }
    var response = await TransactionApi.delete(event.trans.id);
    if (response.isSuccess == false) {
      return;
    }
    CommonToast.tipToast("删除成功");
    emit(TransactionDeleteSuccess(event.trans));
    _handleStatisticUpdate(emit, oldTrans: event.trans.editModel);
  }

  _handleStatisticUpdate(emit, {TransactionEditModel? oldTrans, TransactionEditModel? newTrans}) {
    if (oldTrans == null && newTrans == null) {
      return;
    }
    emit(TransactionStatisticUpdate(oldTrans, newTrans));
  }

  bool _verificationData(TransactionEditModel data, emit) {
    if (data.categoryId == 0) {
      emit(TransactionDataVerificationFails("请选择交易类型"));
      return false;
    }
    if (data.accountId == 0) {
      emit(TransactionDataVerificationFails("请选择账本"));
      return false;
    }
    if (data.amount <= 0) {
      emit(TransactionDataVerificationFails("金额需大于0"));
      return false;
    }
    if (data.amount > Constant.maxAmount) {
      emit(TransactionDataVerificationFails("金额过大"));
      return false;
    }
    if (data.tradeTime.year > Constant.maxYear || data.tradeTime.year < Constant.minYear) {
      emit(TransactionDataVerificationFails("时间超过范围"));
      return false;
    }
    emit(TransactionDataVerificationSuccess());
    return true;
  }
}