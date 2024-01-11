part of 'transaction_bloc.dart';

@immutable
sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

final class TransactionLoaded extends TransactionState {
  final TransactionModel transaction;
  TransactionLoaded(this.transaction);
}

/// 数据校验成功
final class TransactionDataVerificationSuccess extends TransactionState {
  TransactionDataVerificationSuccess();
}

/// 数据校验失败
final class TransactionDataVerificationFails extends TransactionState {
  final String tip;
  TransactionDataVerificationFails(this.tip);
}

/// 添加成功
final class TransactionAddSuccess extends TransactionState {
  final TransactionModel trans;
  TransactionAddSuccess(this.trans);
}

/// 修改成功
final class TransactionUpdateSuccess extends TransactionState {
  final TransactionModel oldTrans;
  final TransactionModel newTrans;
  TransactionUpdateSuccess(this.oldTrans, this.newTrans);
}

/// 删除成功
final class TransactionDeleteSuccess extends TransactionState {
  final TransactionModel delTrans;
  TransactionDeleteSuccess(this.delTrans);
}

/// 统计数据修改
final class TransactionStatisticUpdate extends TransactionState {
  final TransactionEditModel? oldTrans;
  final TransactionEditModel? newTrans;
  TransactionStatisticUpdate(this.oldTrans, this.newTrans);
}

/// 分享数据加载
final class TransactionShareLoaded extends TransactionState {
  final TransactionShareModel shareModel;
  TransactionShareLoaded(this.shareModel);
}
