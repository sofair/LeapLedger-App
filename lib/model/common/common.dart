import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:keepaccount_app/common/global.dart';
import 'package:keepaccount_app/util/enter.dart';

class BaseTransactionCategoryModel {
  late int id;
  @JsonKey(defaultValue: '')
  late String name;
  @JsonKey(fromJson: Json.iconDataFormJson, toJson: Json.iconDataToJson)
  late IconData icon;
  @JsonKey(defaultValue: IncomeExpense.income)
  late IncomeExpense incomeExpense;

  BaseTransactionCategoryModel({required this.id, required this.name, required this.icon, required this.incomeExpense});
}
