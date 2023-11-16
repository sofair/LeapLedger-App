// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonCaptchaModel _$CommonCaptchaModelFromJson(Map<String, dynamic> json) =>
    CommonCaptchaModel()
      ..picBase64 = json['PicBase64'] as String? ?? ''
      ..captchaId = json['CaptchaId'] as String? ?? '';

Map<String, dynamic> _$CommonCaptchaModelToJson(CommonCaptchaModel instance) =>
    <String, dynamic>{
      'PicBase64': instance.picBase64,
      'CaptchaId': instance.captchaId,
    };

UserInfoUpdateModel _$UserInfoUpdateModelFromJson(Map<String, dynamic> json) =>
    UserInfoUpdateModel()..username = json['Username'] as String?;

Map<String, dynamic> _$UserInfoUpdateModelToJson(
        UserInfoUpdateModel instance) =>
    <String, dynamic>{
      'Username': instance.username,
    };
