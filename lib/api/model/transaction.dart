part of 'model.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class TransactionQueryConditionApiModel {
  int accountId;
  Set<int>? userIds;
  Set<int>? categoryIds;
  IncomeExpense? incomeExpense;
  int? minimumAmount;
  int? maximumAmount;
  // 起始时间（时间戳）
  @JsonKey(fromJson: Json.dateTimeFromJson, toJson: Json.dateTimeToJson)
  DateTime startTime;
  // 结束时间（时间戳）
  @JsonKey(fromJson: Json.dateTimeFromJson, toJson: Json.dateTimeToJson)
  DateTime endTime;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TransactionQueryConditionApiModel) {
      return false;
    }
    if (other.accountId != accountId) {
      return false;
    }
    if (other.userIds != userIds) {
      return false;
    }
    if (other.categoryIds != categoryIds) {
      return false;
    }
    if (other.incomeExpense != incomeExpense) {
      return false;
    }
    if (other.minimumAmount != minimumAmount) {
      return false;
    }
    if (other.maximumAmount != maximumAmount) {
      return false;
    }
    if (other.startTime != startTime) {
      return false;
    }
    if (other.endTime != endTime) {
      return false;
    }
    return true;
  }

  TransactionQueryConditionApiModel({
    required this.accountId,
    required this.startTime,
    required this.endTime,
    this.userIds,
    this.categoryIds,
    this.incomeExpense,
    this.minimumAmount,
    this.maximumAmount,
  });

  factory TransactionQueryConditionApiModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionQueryConditionApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionQueryConditionApiModelToJson(this);

  @override
  int get hashCode => super.hashCode;
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class TransactionCategoryAmountRankApiModel extends AmountCountApiModel {
  TransactionCategoryModel category;

  TransactionCategoryAmountRankApiModel({
    required int amount,
    required int count,
    required this.category,
  }) : super(amount, count);
  factory TransactionCategoryAmountRankApiModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionCategoryAmountRankApiModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TransactionCategoryAmountRankApiModelToJson(this);
}
