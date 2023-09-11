part of 'package:keepaccount_app/model/transaction/category/model.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class TransactionCategoryModel {
  @JsonKey(defaultValue: 0)
  late int id;
  @JsonKey(defaultValue: 0)
  late int fatherId;
  @JsonKey(defaultValue: 0)
  late int accountId;
  @JsonKey(defaultValue: '')
  late String name;
  @JsonKey(defaultValue: IncomeExpense.income)
  late IncomeExpense incomeExpense;
  @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  late DateTime createdAt;
  @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  late DateTime updatedAt;
  TransactionCategoryModel();
  factory TransactionCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionCategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionCategoryModelToJson(this);
}
