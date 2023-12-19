part of 'model.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class UserInfoUpdateModel {
  late String? username;
  UserInfoUpdateModel();
  factory UserInfoUpdateModel.fromJson(Map<String, dynamic> json) => _$UserInfoUpdateModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoUpdateModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)

///首页接口数据模型
class UserHomeApiModel {
  late UserHomeHeaderCardApiModel? headerCard;
  late UserHomeTimePeriodStatisticsApiModel? timePeriodStatistics;
  UserHomeApiModel();
  factory UserHomeApiModel.fromJson(Map<String, dynamic> json) => _$UserHomeApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserHomeApiModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class UserHomeHeaderCardApiModel extends IncomeExpenseStatisticApiModel {
  UserHomeHeaderCardApiModel({AmountCountApiModel? income, AmountCountApiModel? expense})
      : super(income: income, expense: expense);
  int? get days => startTime != null && endTime != null ? endTime!.difference(startTime!).inDays : null;
  int get dayExpenseAmountaverage {
    if (days == null || expense.amount <= 0) {
      return 0;
    }
    return expense.amount ~/ days!;
  }

  factory UserHomeHeaderCardApiModel.fromJson(Map<String, dynamic> json) => _$UserHomeHeaderCardApiModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UserHomeHeaderCardApiModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)

///首页时间段统计接口数据模型
class UserHomeTimePeriodStatisticsApiModel {
  late IncomeExpenseStatisticApiModel todayData;
  late IncomeExpenseStatisticApiModel yesterdayData;
  late IncomeExpenseStatisticApiModel weekData;
  late IncomeExpenseStatisticApiModel yearData;
  UserHomeTimePeriodStatisticsApiModel({
    required this.todayData,
    required this.yesterdayData,
    required this.weekData,
    required this.yearData,
  });
  factory UserHomeTimePeriodStatisticsApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserHomeTimePeriodStatisticsApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserHomeTimePeriodStatisticsApiModelToJson(this);
}
