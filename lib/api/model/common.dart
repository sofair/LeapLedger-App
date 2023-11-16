part of 'model.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CommonCaptchaModel {
  @JsonKey(defaultValue: '')
  late String picBase64;
  @JsonKey(defaultValue: '')
  late String captchaId;
  CommonCaptchaModel();
  factory CommonCaptchaModel.fromJson(Map<String, dynamic> json) => _$CommonCaptchaModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommonCaptchaModelToJson(this);
}
