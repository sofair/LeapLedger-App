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

  TransactionEditModel get editModel => TransactionEditModel(
      id: id > 0 ? id : null,
      userId: userId,
      accountId: accountId,
      categoryId: categoryId,
      incomeExpense: incomeExpense,
      amount: amount,
      remark: remark,
      tradeTime: tradeTime);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class TransactionEditModel {
  late int? id;
  late int userId;
  late int accountId;
  late int categoryId;
  late IncomeExpense incomeExpense;
  late int amount;
  late String remark;
  @JsonKey(fromJson: Json.dateTimeFromJson, toJson: Json.dateTimeToJson)
  late DateTime tradeTime;
  TransactionEditModel({
    this.id,
    required this.userId,
    required this.accountId,
    required this.categoryId,
    required this.incomeExpense,
    required this.amount,
    required this.remark,
    required this.tradeTime,
  });
  TransactionEditModel.init() {
    id = null;
    userId = 0;
    accountId = 0;
    categoryId = 0;
    incomeExpense = IncomeExpense.expense;
    amount = 0;
    remark = "";
    tradeTime = DateTime.now();
  }
  factory TransactionEditModel.fromJson(Map<String, dynamic> json) => _$TransactionEditModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionEditModelToJson(this);
  TransactionEditModel copy() {
    return TransactionEditModel(
      id: id,
      userId: userId,
      accountId: accountId,
      categoryId: categoryId,
      incomeExpense: incomeExpense,
      amount: amount,
      remark: remark,
      tradeTime: tradeTime,
    );
  }
}
