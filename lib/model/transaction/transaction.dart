part of 'model.dart';

/// 交易模型
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

  TransactionShareModel getShareModelByConfig(UserTransactionShareConfigModel config) {
    TransactionShareModel model = TransactionShareModel(
      id: id,
      amount: amount,
      tradeTime: tradeTime,
      incomeExpense: incomeExpense,
      categoryIcon: categoryIcon,
      categoryName: categoryName,
      categoryFatherName: categoryFatherName,
      userName: userName,
    );
    if (config.account) {
      model.accountName = accountName;
    }
    if (config.createTime) {
      model.createTime = createTime;
    }
    if (config.updateTime) {
      model.updateTime = updateTime;
    }
    if (config.remark) {
      model.remark = remark;
    }
    return model;
  }
}

/// 交易编辑模型
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

/// 交易分享模型
@JsonSerializable(fieldRename: FieldRename.pascal)
class TransactionShareModel {
  @JsonKey(defaultValue: 0)
  late int id;
  @JsonKey(defaultValue: '')
  late String? userName;
  @JsonKey(defaultValue: '')
  late String? accountName;
  @JsonKey(defaultValue: IncomeExpense.income)
  late IncomeExpense incomeExpense;
  @JsonKey(fromJson: Json.optionIconDataFormJson, toJson: Json.optionIconDataToJson)
  late IconData? categoryIcon;
  @JsonKey(defaultValue: '')
  late String? categoryName;
  @JsonKey(defaultValue: '')
  late String? categoryFatherName;
  @JsonKey(defaultValue: 0)
  late int amount;
  @JsonKey(defaultValue: '')
  late String? remark;
  @JsonKey(fromJson: Json.dateTimeFromJson, toJson: Json.dateTimeToJson)
  late DateTime? tradeTime;
  @JsonKey(fromJson: Json.dateTimeFromJson, toJson: Json.dateTimeToJson)
  late DateTime? createTime;
  @JsonKey(fromJson: Json.dateTimeFromJson, toJson: Json.dateTimeToJson)
  late DateTime? updateTime;
  TransactionShareModel({
    required this.id,
    required this.amount,
    required this.incomeExpense,
    this.userName,
    this.accountName,
    this.categoryIcon,
    this.categoryName,
    this.categoryFatherName,
    this.remark,
    this.tradeTime,
    this.createTime,
    this.updateTime,
  });
  factory TransactionShareModel.fromJson(Map<String, dynamic> json) => _$TransactionShareModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionShareModelToJson(this);
}
