part of 'transaction_category_tree_bloc.dart';

abstract class TransactionCategoryTreeEvent {}

class LoadEvent extends TransactionCategoryTreeEvent {
  late IncomeExpense incomeExpense;
  LoadEvent(this.incomeExpense);
}

class MoveChildEvent extends TransactionCategoryTreeEvent {
  final int oldChildIndex, oldFatherIndex, newChildIndex, newFatherIndex;
  MoveChildEvent(this.oldChildIndex, this.oldFatherIndex, this.newChildIndex,
      this.newFatherIndex);
}

class MoveFatherEvent extends TransactionCategoryTreeEvent {
  final int oldFatherIndex, newFatherIndex;
  MoveFatherEvent(this.oldFatherIndex, this.newFatherIndex);
}

class DeleteChildEvent extends TransactionCategoryTreeEvent {
  final int id;
  DeleteChildEvent(this.id);
}

class DeleteFatherEvent extends TransactionCategoryTreeEvent {
  final int id;
  DeleteFatherEvent(this.id);
}

class AddChildEvent extends TransactionCategoryTreeEvent {
  final TransactionCategoryModel transactionCategoryModel;
  AddChildEvent(this.transactionCategoryModel);
}

class AddFatherEvent extends TransactionCategoryTreeEvent {
  final TransactionCategoryFatherModel transactionCategoryFatherModel;
  AddFatherEvent(this.transactionCategoryFatherModel);
}

class UpdateChildEvent extends TransactionCategoryTreeEvent {
  final TransactionCategoryModel transactionCategoryModel;
  UpdateChildEvent(this.transactionCategoryModel);
}

class UpdateFatherEvent extends TransactionCategoryTreeEvent {
  final TransactionCategoryFatherModel transactionCategoryFatherModel;
  UpdateFatherEvent(this.transactionCategoryFatherModel);
}
