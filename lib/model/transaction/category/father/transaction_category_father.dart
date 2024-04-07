part of 'package:keepaccount_app/model/transaction/category/model.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class TransactionCategoryFatherModel {
  @JsonKey(defaultValue: 0)
  late int id;
  @JsonKey(defaultValue: 0)
  late int accountId;
  @JsonKey(defaultValue: '')
  late String name;
  @JsonKey(defaultValue: IncomeExpense.income)
  late IncomeExpense incomeExpense;
  @JsonKey(fromJson: Json.dateTimeFromJson, toJson: Json.dateTimeToJson)
  late DateTime createdAt;
  @JsonKey(fromJson: Json.dateTimeFromJson, toJson: Json.dateTimeToJson)
  late DateTime updatedAt;
  TransactionCategoryFatherModel();
  factory TransactionCategoryFatherModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionCategoryFatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionCategoryFatherModelToJson(this);

  bool get isValid => id > 0;
}
