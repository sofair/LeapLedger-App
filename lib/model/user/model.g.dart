// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel()
  ..id = json['Id'] as int? ?? 0
  ..username = json['Username'] as String? ?? ''
  ..email = json['Email'] as String? ?? ''
  ..createTime = Json.dateTimeFromJson(json['CreateTime'])
  ..updateTime = Json.dateTimeFromJson(json['UpdateTime']);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'Id': instance.id,
      'Username': instance.username,
      'Email': instance.email,
      'CreateTime': Json.dateTimeToJson(instance.createTime),
      'UpdateTime': Json.dateTimeToJson(instance.updateTime),
    };
