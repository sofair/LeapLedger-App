// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonCaptchaModel _$CommonCaptchaModelFromJson(Map<String, dynamic> json) =>
    CommonCaptchaModel()
      ..picBase64 = json['PicBase64'] as String? ?? ''
      ..captchaId = json['CaptchaId'] as String? ?? '';

Map<String, dynamic> _$CommonCaptchaModelToJson(CommonCaptchaModel instance) =>
    <String, dynamic>{
      'PicBase64': instance.picBase64,
      'CaptchaId': instance.captchaId,
    };

AmountCountApiModel _$AmountCountApiModelFromJson(Map<String, dynamic> json) =>
    AmountCountApiModel(
      json['Amount'] as int? ?? 0,
      json['Count'] as int? ?? 0,
    );

Map<String, dynamic> _$AmountCountApiModelToJson(
        AmountCountApiModel instance) =>
    <String, dynamic>{
      'Amount': instance.amount,
      'Count': instance.count,
    };

IncomeExpenseStatisticApiModel _$IncomeExpenseStatisticApiModelFromJson(
        Map<String, dynamic> json) =>
    IncomeExpenseStatisticApiModel(
      income: json['Income'] == null
          ? null
          : AmountCountApiModel.fromJson(
              json['Income'] as Map<String, dynamic>),
      expense: json['Expense'] == null
          ? null
          : AmountCountApiModel.fromJson(
              json['Expense'] as Map<String, dynamic>),
    )
      ..startTime = Json.optionDateTimeFromJson(json['StartTime'])
      ..endTime = Json.optionDateTimeFromJson(json['EndTime']);

Map<String, dynamic> _$IncomeExpenseStatisticApiModelToJson(
        IncomeExpenseStatisticApiModel instance) =>
    <String, dynamic>{
      'Income': instance.income,
      'Expense': instance.expense,
      'StartTime': Json.optionDateTimeToJson(instance.startTime),
      'EndTime': Json.optionDateTimeToJson(instance.endTime),
    };

UserInfoUpdateModel _$UserInfoUpdateModelFromJson(Map<String, dynamic> json) =>
    UserInfoUpdateModel()..username = json['Username'] as String?;

Map<String, dynamic> _$UserInfoUpdateModelToJson(
        UserInfoUpdateModel instance) =>
    <String, dynamic>{
      'Username': instance.username,
    };

TransactionQueryConditionApiModel _$TransactionQueryConditionApiModelFromJson(
        Map<String, dynamic> json) =>
    TransactionQueryConditionApiModel(
      accountId: json['AccountId'] as int,
      startTime: Json.dateTimeFromJson(json['StartTime']),
      endTime: Json.dateTimeFromJson(json['EndTime']),
      userIds:
          (json['UserIds'] as List<dynamic>?)?.map((e) => e as int).toSet(),
      categoryIds:
          (json['CategoryIds'] as List<dynamic>?)?.map((e) => e as int).toSet(),
      incomeExpense:
          $enumDecodeNullable(_$IncomeExpenseEnumMap, json['IncomeExpense']),
      minimumAmount: json['MinimumAmount'] as int?,
      maximumAmount: json['MaximumAmount'] as int?,
    );

Map<String, dynamic> _$TransactionQueryConditionApiModelToJson(
        TransactionQueryConditionApiModel instance) =>
    <String, dynamic>{
      'AccountId': instance.accountId,
      'UserIds': instance.userIds?.toList(),
      'CategoryIds': instance.categoryIds?.toList(),
      'IncomeExpense': _$IncomeExpenseEnumMap[instance.incomeExpense],
      'MinimumAmount': instance.minimumAmount,
      'MaximumAmount': instance.maximumAmount,
      'StartTime': Json.dateTimeToJson(instance.startTime),
      'EndTime': Json.dateTimeToJson(instance.endTime),
    };

const _$IncomeExpenseEnumMap = {
  IncomeExpense.income: 'income',
  IncomeExpense.expense: 'expense',
};
