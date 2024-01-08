part of 'transaction_bloc.dart';

@immutable
sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

final class TransactionLoaded extends TransactionState {
  final TransactionModel transaction;
  TransactionLoaded(this.transaction);
}

final class TransactionDataVerificationSuccess extends TransactionState {
  TransactionDataVerificationSuccess();
}

final class TransactionDataVerificationFails extends TransactionState {
  final String tip;
  TransactionDataVerificationFails(this.tip);
}

final class TransactionAddSuccess extends TransactionState {
  final TransactionModel trans;
  TransactionAddSuccess(this.trans);
}

final class TransactionUpdateSuccess extends TransactionState {
  final TransactionModel oldTrans;
  final TransactionModel newTrans;
  TransactionUpdateSuccess(this.oldTrans, this.newTrans);
}

final class TransactionDeleteSuccess extends TransactionState {
  final TransactionModel delTrans;
  TransactionDeleteSuccess(this.delTrans);
}

final class TransactionStatisticUpdate extends TransactionState {
  final TransactionEditModel? oldTrans;
  final TransactionEditModel? newTrans;
  TransactionStatisticUpdate(this.oldTrans, this.newTrans);
}
