part of 'model.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class TransactionModel {
  @JsonKey(defaultValue: 0)
  late int id;
  @JsonKey(defaultValue: 0)
  late int userId;
  @JsonKey(defaultValue: '')
  late String userName;
  @JsonKey(defaultValue: 0)
  late int accountId;
  @JsonKey(defaultValue: '')
  late String accountName;
  @JsonKey(defaultValue: IncomeExpense.income)
  late IncomeExpense incomeExpense;
  @JsonKey(defaultValue: 0)
  late int categoryId;
  @JsonKey(fromJson: Json.iconDataFormJson, toJson: Json.iconDataToJson)
  late IconData categoryIcon;
  @JsonKey(defaultValue: '')
  late String categoryName;
  @JsonKey(defaultValue: '')
  late String categoryFatherName;
  @JsonKey(defaultValue: 0)
  late int amount;
  @JsonKey(defaultValue: '')
  late String remark;
  @JsonKey(fromJson: Json.dateTimeFromJson, toJson: Json.dateTimeToJson)
  late DateTime tradeTime;
  @JsonKey(fromJson: Json.dateTimeFromJson, toJson: Json.dateTimeToJson)
  late DateTime createTime;
  @JsonKey(fromJson: Json.dateTimeFromJson, toJson: Json.dateTimeToJson)
  late DateTime updateTime;
  TransactionModel();
  factory TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
