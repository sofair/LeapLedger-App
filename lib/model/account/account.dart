part of 'model.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class AccountModel {
  @JsonKey(defaultValue: 0)
  late int id;
  @JsonKey(defaultValue: '')
  late String name;
  @JsonKey(fromJson: Json.iconDataFormJson, toJson: Json.iconDataToJson)
  late IconData icon;
  @JsonKey(fromJson: Json.dateTimeFromJson, toJson: Json.dateTimeToJson)
  late DateTime createdAt;
  @JsonKey(fromJson: Json.dateTimeFromJson, toJson: Json.dateTimeToJson)
  late DateTime updatedAt;

  AccountModel();

  factory AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccountModelToJson(this);

  copyWith(AccountModel other) {
    id = other.id;
    name = other.name;
    icon = other.icon;
    createdAt = other.createdAt;
    updatedAt = other.updatedAt;
  }
}
