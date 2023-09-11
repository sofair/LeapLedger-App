// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => AccountModel()
  ..name = json['Name'] as String? ?? ''
  ..id = json['Id'] as int? ?? 0
  ..createdAt = dateTimeFromJson(json['CreatedAt'])
  ..updatedAt = dateTimeFromJson(json['UpdatedAt']);

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Id': instance.id,
      'CreatedAt': dateTimeToJson(instance.createdAt),
      'UpdatedAt': dateTimeToJson(instance.updatedAt),
    };
