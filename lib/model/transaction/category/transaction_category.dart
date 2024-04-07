part of 'package:keepaccount_app/model/transaction/category/model.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class TransactionCategoryModel extends BaseTransactionCategoryModel {
  @JsonKey(defaultValue: 0)
  late int fatherId;
  @JsonKey(defaultValue: 0)
  late int accountId;
  @JsonKey(fromJson: Json.dateTimeFromJson, toJson: Json.dateTimeToJson)
  late DateTime createdAt;
  @JsonKey(fromJson: Json.dateTimeFromJson, toJson: Json.dateTimeToJson)
  late DateTime updatedAt;
  TransactionCategoryModel({required super.id, required super.name, required super.icon, required super.incomeExpense});
  factory TransactionCategoryModel.fromJson(Map<String, dynamic> json) => _$TransactionCategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionCategoryModelToJson(this);
}
