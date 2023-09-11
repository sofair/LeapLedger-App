part of 'model.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ProductModel {
  @JsonKey(defaultValue: '')
  late String uniqueKey;
  @JsonKey(defaultValue: '')
  late String name;

  ProductModel();

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
