part of 'transaction_category_mapping_bloc.dart';

@immutable
abstract class TransactionCategoryMappingState {}

class TransactionCategoryMappingInitial extends TransactionCategoryMappingState {}

class LoadingState extends TransactionCategoryMappingState {}

abstract class TransactionCategoryMappingLoaded extends TransactionCategoryMappingState {
  List<BaseTransactionCategoryModel> get unmapped;
  Map<int, List<BaseTransactionCategoryModel>> get relation;
}

class TransactionCategoryMappingExpenseLoaded extends TransactionCategoryMappingLoaded {
  @override
  final List<BaseTransactionCategoryModel> unmapped;
  @override
  final Map<int, List<BaseTransactionCategoryModel>> relation;
  TransactionCategoryMappingExpenseLoaded(this.unmapped, this.relation);
}

class TransactionCategoryMappingIncomeLoaded extends TransactionCategoryMappingLoaded {
  @override
  final List<BaseTransactionCategoryModel> unmapped;
  @override
  final Map<int, List<BaseTransactionCategoryModel>> relation;
  TransactionCategoryMappingIncomeLoaded(this.unmapped, this.relation);
}
