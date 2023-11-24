part of 'transaction_category_mapping_bloc.dart';

@immutable
abstract class TransactionCategoryMappingState {}

class TransactionCategoryMappingInitial extends TransactionCategoryMappingState {}

class LoadingState extends TransactionCategoryMappingState {}

abstract class TransactionCategoryMappingLoaded extends TransactionCategoryMappingState {
  List<ProductTransactionCategoryModel> get unmapped;
  Map<int, List<ProductTransactionCategoryModel>> get relation;
}

class TransactionCategoryMappingExpenseLoaded extends TransactionCategoryMappingLoaded {
  @override
  final List<ProductTransactionCategoryModel> unmapped;
  @override
  final Map<int, List<ProductTransactionCategoryModel>> relation;
  TransactionCategoryMappingExpenseLoaded(this.unmapped, this.relation);
}

class TransactionCategoryMappingIncomeLoaded extends TransactionCategoryMappingLoaded {
  @override
  final List<ProductTransactionCategoryModel> unmapped;
  @override
  final Map<int, List<ProductTransactionCategoryModel>> relation;
  TransactionCategoryMappingIncomeLoaded(this.unmapped, this.relation);
}
