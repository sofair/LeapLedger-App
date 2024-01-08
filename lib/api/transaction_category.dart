part of 'api_server.dart';

class TransactionCategoryApi {
  static String baseUrl = '/transaction/category';
  static TransactionCategoryApiData dataFormatFunc = TransactionCategoryApiData();
  static Future<ResponseBody> getTree({IncomeExpense? type, int? accountId}) async {
    accountId ??= UserBloc.currentAccount.id;

    ResponseBody response = await ApiServer.request(
      Method.get,
      '$baseUrl/tree',
      data: {'AccountId': accountId, 'IncomeExpense': type?.name},
    );
    if (response.isSuccess && response.data['Tree'] is List) {
      response.data['Tree'] = response.data['Tree'].map((value) {
        value['IncomeExpense'] = type?.name;
        value['AccountId'] = accountId;
        if (value['Children'] is List) {
          value['Children'] = value['Children'].map((value) {
            value['IncomeExpense'] = type?.name;
            value['AccountId'] = accountId;
            return value;
          }).toList();
        }
        return value;
      }).toList();
    }
    return response;
  }

  static Future<ResponseBody> moveCategoryChild(int id, {int? previous, int? fatherId}) async {
    return await ApiServer.request(Method.post, '$baseUrl/$id/move',
        data: {'Previous': previous, 'FatherId': fatherId});
  }

  static Future<ResponseBody> moveCategoryFather(int id, {int? previous}) async {
    return await ApiServer.request(Method.post, '$baseUrl/father/$id/move', data: {'Previous': previous});
  }

  static Future<ResponseBody> addCategoryChild(TransactionCategoryModel model) async {
    return await ApiServer.request(Method.post, baseUrl, data: model.toJson());
  }

  static Future<ResponseBody> addCategoryFather(TransactionCategoryFatherModel model) async {
    return await ApiServer.request(Method.post, '$baseUrl/father', data: model.toJson());
  }

  static Future<ResponseBody> deleteCategoryChild(int id) async {
    return await ApiServer.request(Method.delete, '$baseUrl/$id');
  }

  static Future<ResponseBody> deleteCategoryFather(int id) async {
    return await ApiServer.request(Method.delete, '$baseUrl/father/$id');
  }

  static Future<ResponseBody> updateCategoryChild(TransactionCategoryModel model) async {
    return await ApiServer.request(Method.put, '$baseUrl/${model.id}', data: model.toJson());
  }

  static Future<ResponseBody> updateCategoryFather(TransactionCategoryFatherModel model) async {
    return await ApiServer.request(Method.put, '$baseUrl/father/${model.id}', data: model.toJson());
  }
}

class TransactionCategoryApiData {
  List<MapEntry<TransactionCategoryFatherModel, List<TransactionCategoryModel>>> getTreeDataToList(
      ResponseBody response) {
    List<MapEntry<TransactionCategoryFatherModel, List<TransactionCategoryModel>>> result = [];
    if (response.isSuccess && response.data['Tree'] != null) {
      for (LinkedHashMap<String, dynamic> data in response.data['Tree']) {
        List<TransactionCategoryModel> children = [];
        TransactionCategoryFatherModel father = TransactionCategoryFatherModel.fromJson(data);
        for (Map<String, dynamic> child in data['Children']) {
          children.add(TransactionCategoryModel.fromJson(child)..fatherId = father.id);
        }
        result.add(MapEntry(father, children));
      }
    }
    return result;
  }

  List<TransactionCategoryModel> getCategoryListByTree(ResponseBody response) {
    List<TransactionCategoryModel> categoryList = [];
    if (response.isSuccess && response.data['Tree'] != null) {
      for (LinkedHashMap<String, dynamic> data in response.data['Tree']) {
        TransactionCategoryFatherModel father = TransactionCategoryFatherModel.fromJson(data);
        for (Map<String, dynamic> child in data['Children']) {
          categoryList.add(TransactionCategoryModel.fromJson(child)..fatherId = father.id);
        }
      }
    }
    return categoryList;
  }
}
