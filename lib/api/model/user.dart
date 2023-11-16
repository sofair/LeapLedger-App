part of 'model.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class UserInfoUpdateModel {
  late String? username;
  UserInfoUpdateModel();
  factory UserInfoUpdateModel.fromJson(Map<String, dynamic> json) => _$UserInfoUpdateModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoUpdateModelToJson(this);
}
