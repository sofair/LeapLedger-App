// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel()
      ..id = json['Id'] as int? ?? 0
      ..accountId = json['AccountId'] as int? ?? 0
      ..incomeExpense = json['IncomeExpense'] as String? ?? ''
      ..categoryId = json['CategoryId'] as int? ?? 0
      ..amount = json['Amount'] as int? ?? 0
      ..remark = json['Remark'] as String? ?? ''
      ..tradeTime = Json.dateTimeFromJson(json['TradeTime'])
      ..createTime = Json.dateTimeFromJson(json['CreateTime'])
      ..updateTime = Json.dateTimeFromJson(json['UpdateTime']);

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'AccountId': instance.accountId,
      'IncomeExpense': instance.incomeExpense,
      'CategoryId': instance.categoryId,
      'Amount': instance.amount,
      'Remark': instance.remark,
      'TradeTime': Json.dateTimeToJson(instance.tradeTime),
      'CreateTime': Json.dateTimeToJson(instance.createTime),
      'UpdateTime': Json.dateTimeToJson(instance.updateTime),
    };
