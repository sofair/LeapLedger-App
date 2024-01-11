part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {}

class TransactionDataFetch extends TransactionEvent {
  final AccountModel account;
  final int id;
  TransactionDataFetch(this.account, this.id);
}

class TransactionDelete extends TransactionEvent {
  final AccountModel account;
  final TransactionModel trans;
  TransactionDelete(this.account, this.trans);
}

class TransactionUpdate extends TransactionEvent {
  final TransactionModel oldTrans;
  final TransactionEditModel editModel;
  TransactionUpdate(this.oldTrans, this.editModel);
}

class TransactionAdd extends TransactionEvent {
  final TransactionEditModel editModel;
  TransactionAdd(this.editModel);
}

class TransactionShare extends TransactionEvent {
  final TransactionModel trans;
  TransactionShare(this.trans);
}
