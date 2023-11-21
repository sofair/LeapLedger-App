part of '../model.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class AccountTemplateModel {
  @JsonKey(defaultValue: 0)
  late int id;
  @JsonKey(defaultValue: '')
  late String name;
  @JsonKey(fromJson: Json.iconDataFormJson, toJson: Json.iconDataToJson)
  late IconData icon;

  AccountTemplateModel();

  factory AccountTemplateModel.fromJson(Map<String, dynamic> json) => _$AccountTemplateModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccountTemplateModelToJson(this);
}
