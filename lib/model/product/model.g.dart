// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel()
  ..uniqueKey = json['UniqueKey'] as String? ?? ''
  ..name = json['Name'] as String? ?? '';

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'UniqueKey': instance.uniqueKey,
      'Name': instance.name,
    };

ProductTransactionCategoryModel _$ProductTransactionCategoryModelFromJson(
        Map<String, dynamic> json) =>
    ProductTransactionCategoryModel()
      ..id = json['Id'] as int? ?? 0
      ..uniqueKey = json['UniqueKey'] as String? ?? ''
      ..name = json['Name'] as String? ?? ''
      ..incomeExpense =
          $enumDecodeNullable(_$IncomeExpenseEnumMap, json['IncomeExpense']) ??
              IncomeExpense.income;

Map<String, dynamic> _$ProductTransactionCategoryModelToJson(
        ProductTransactionCategoryModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'UniqueKey': instance.uniqueKey,
      'Name': instance.name,
      'IncomeExpense': _$IncomeExpenseEnumMap[instance.incomeExpense]!,
    };

const _$IncomeExpenseEnumMap = {
  IncomeExpense.income: 'income',
  IncomeExpense.expense: 'expense',
};

ProductTransactionCategoryMappingModel
    _$ProductTransactionCategoryMappingModelFromJson(
            Map<String, dynamic> json) =>
        ProductTransactionCategoryMappingModel()
          ..accountId = json['AccountId'] as int? ?? 0
          ..ptcId = json['PtcId'] as int? ?? 0
          ..categoryId = json['CategoryId'] as int? ?? 0
          ..productKey = json['ProductKey'] as int? ?? 0
          ..createdAt = DateTime.parse(json['CreatedAt'] as String)
          ..updatedAt = DateTime.parse(json['UpdatedAt'] as String);

Map<String, dynamic> _$ProductTransactionCategoryMappingModelToJson(
        ProductTransactionCategoryMappingModel instance) =>
    <String, dynamic>{
      'AccountId': instance.accountId,
      'PtcId': instance.ptcId,
      'CategoryId': instance.categoryId,
      'ProductKey': instance.productKey,
      'CreatedAt': instance.createdAt.toIso8601String(),
      'UpdatedAt': instance.updatedAt.toIso8601String(),
    };
