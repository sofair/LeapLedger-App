import 'package:json_annotation/json_annotation.dart';
import 'package:keepaccount_app/api/api_server.dart';
import 'package:keepaccount_app/bloc/user/user_bloc.dart';
import 'package:keepaccount_app/util/enter.dart';

part 'account.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class AccountModel {
  @JsonKey(defaultValue: '')
  late String name;
  @JsonKey(defaultValue: 0)
  late int id;
  @JsonKey(fromJson: Json.dateTimeFromJson, toJson: Json.dateTimeToJson)
  late DateTime createdAt;
  @JsonKey(fromJson: Json.dateTimeFromJson, toJson: Json.dateTimeToJson)
  late DateTime updatedAt;

  AccountModel();

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccountModelToJson(this);
  static Future<AccountModel> getCurrent() async {
    return await AccountApi.getOne(UserBloc.currentAccount.id);
  }
}
