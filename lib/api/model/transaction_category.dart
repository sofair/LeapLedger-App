part of 'model.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class TransactionCategoryMappingTreeNodeApiModel {
  List<int> childrenIds;
  int fatherId;

  TransactionCategoryMappingTreeNodeApiModel({
    required this.childrenIds,
    required this.fatherId,
  });
  factory TransactionCategoryMappingTreeNodeApiModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionCategoryMappingTreeNodeApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionCategoryMappingTreeNodeApiModelToJson(this);
}
