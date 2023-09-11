part of 'trans_cat_father_bloc.dart';

abstract class TransCatFatherEvent {}

class TransCatFatherSaveEvent extends TransCatFatherEvent {
  final TransactionCategoryFatherModel transactionCategoryFather;
  TransCatFatherSaveEvent(this.transactionCategoryFather);
}

class TransCatFatherDeleteEvent extends TransCatFatherEvent {
  final TransactionCategoryFatherModel transactionCategoryFather;
  TransCatFatherDeleteEvent(this.transactionCategoryFather);
}
