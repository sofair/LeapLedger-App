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

@JsonSerializable(fieldRename: FieldRename.pascal)
class AmountCountApiModel {
  @JsonKey(defaultValue: 0)
  late int amount;
  @JsonKey(defaultValue: 0)
  late int count;
  int get average => amount != 0 ? amount ~/ count : 0;
  AmountCountApiModel(this.amount, this.count);
  factory AmountCountApiModel.fromJson(Map<String, dynamic> json) => _$AmountCountApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$AmountCountApiModelToJson(this);
  add(AmountCountApiModel addData) {
    amount += addData.amount;
    count += addData.count;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class IncomeExpenseStatisticApiModel {
  late AmountCountApiModel income;
  late AmountCountApiModel expense;
  Duration? get timeDuration => startTime != null && endTime != null ? endTime!.difference(startTime!) : null;
  int get dayAverageIncome => timeDuration != null && income.amount != 0 ? income.amount ~/ timeDuration!.inDays : 0;
  int get dayAverageExpense => timeDuration != null && expense.amount != 0 ? expense.amount ~/ timeDuration!.inDays : 0;

  @JsonKey(fromJson: Json.optionDateTimeFromJson, toJson: Json.optionDateTimeToJson)
  DateTime? startTime;
  @JsonKey(fromJson: Json.optionDateTimeFromJson, toJson: Json.optionDateTimeToJson)
  DateTime? endTime;
  IncomeExpenseStatisticApiModel({AmountCountApiModel? income, AmountCountApiModel? expense}) {
    this.income = income ?? AmountCountApiModel(0, 0);
    this.expense = expense ?? AmountCountApiModel(0, 0);
  }
  factory IncomeExpenseStatisticApiModel.fromJson(Map<String, dynamic> json) =>
      _$IncomeExpenseStatisticApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeExpenseStatisticApiModelToJson(this);
}
