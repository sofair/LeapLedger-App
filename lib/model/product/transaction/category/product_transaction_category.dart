part of '../../model.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductTransactionCategoryModel {
  @JsonKey(defaultValue: 0)
  late int id;
  @JsonKey(defaultValue: '')
  late String uniqueKey;
  @JsonKey(defaultValue: '')
  late String name;
  @JsonKey(defaultValue: IncomeExpense.income)
  late IncomeExpense incomeExpense;
  ProductTransactionCategoryModel();

  factory ProductTransactionCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ProductTransactionCategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductTransactionCategoryModelToJson(this);
}
