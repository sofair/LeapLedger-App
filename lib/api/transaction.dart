part of 'api_server.dart';

class TransactionApi {
  static String baseUrl = '/transaction';
  static TransactionCategoryApiData dataFormatFunc = TransactionCategoryApiData();

  static Future<ResponseBody> add(TransactionModel model) async {
    return await ApiServer.request(Method.post, baseUrl, data: model.toJson());
  }

  static Future<List<TransactionModel>> getList(
      TransactionQueryConditionApiModel condition, int limit, int offset) async {
    var data = condition.toJson();
    data['Limit'] = limit;
    data['Offset'] = offset;
    var responseBody = await ApiServer.request(Method.get, '$baseUrl/list', data: data);
    List<TransactionModel> result = [];
    if (responseBody.isSuccess) {
      for (Map<String, dynamic> data in responseBody.data['List']) {
        result.add(TransactionModel.fromJson(data));
      }
    }
    return result;
  }

  static Future<List<DayAmountStatisticApiModel>> getDayStatistic({
    required int accountId,
    Set<int>? categoryIds,
    IncomeExpense? ie,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    var responseBody = await ApiServer.request(Method.get, '$baseUrl/day/statistic', data: {
      "AccountId": accountId,
      "CategoryIds": categoryIds,
      "IncomeExpense": ie?.name,
      "StartTime": Json.dateTimeToJson(startTime),
      "EndTime": Json.dateTimeToJson(endTime),
    });
    List<DayAmountStatisticApiModel> result = [];
    if (responseBody.isSuccess && responseBody.data['List'] is List) {
      for (Map<String, dynamic> data in responseBody.data['List'] as List) {
        result.add(DayAmountStatisticApiModel.fromJson(data));
      }
    }
    return result;
  }

  static Future<List<IncomeExpenseStatisticApiModel>> getMonthStatistic(
      TransactionQueryConditionApiModel condition) async {
    var responseBody = await ApiServer.request(Method.get, '$baseUrl/month/statistic', data: condition.toJson());
    List<IncomeExpenseStatisticApiModel> result = [];
    if (responseBody.isSuccess) {
      for (Map<String, dynamic> data in responseBody.data['List']) {
        result.add(IncomeExpenseStatisticApiModel.fromJson(data));
      }
    }
    return result;
  }

  static Future<List<TransactionCategoryAmountRankApiModel>> getCategoryAmountRank({
    required int accountId,
    Set<int>? categoryIds,
    required IncomeExpense ie,
    required int limit,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    var responseBody = await ApiServer.request(Method.get, '$baseUrl/category/amount/rank', data: {
      "AccountId": accountId,
      "CategoryIds": categoryIds,
      "IncomeExpense": ie.name,
      "Limit": limit,
      "StartTime": Json.dateTimeToJson(startTime),
      "EndTime": Json.dateTimeToJson(endTime),
    });
    List<TransactionCategoryAmountRankApiModel> result = [];
    if (responseBody.isSuccess && responseBody.data['List'] is List) {
      for (Map<String, dynamic> data in responseBody.data['List'] as List) {
        result.add(TransactionCategoryAmountRankApiModel.fromJson(data));
      }
    }
    return result;
  }
}
