part of 'api_server.dart';

class TransactionApi {
  static String baseUrl = '/transaction';
  static TransactionCategoryApiData dataFormatFunc =
      TransactionCategoryApiData();

  static Future<ResponseBody> add(TransactionModel model) async {
    return await ApiServer.request(Method.post, baseUrl, data: model.toJson());
  }

  static Future<ResponseBody> addCategoryFather(
      TransactionCategoryFatherModel model) async {
    return await ApiServer.request(Method.post, '$baseUrl/father',
        data: model.toJson());
  }

  static Future<ResponseBody> deleteCategoryChild(int id) async {
    return await ApiServer.request(Method.delete, '$baseUrl/$id');
  }

  static Future<ResponseBody> deleteCategoryFather(int id) async {
    return await ApiServer.request(Method.delete, '$baseUrl/father/$id');
  }

  static Future<ResponseBody> updateCategoryChild(
      TransactionCategoryModel model) async {
    return await ApiServer.request(Method.put, '$baseUrl/${model.id}',
        data: model.toJson());
  }

  static Future<ResponseBody> updateCategoryFather(
      TransactionCategoryFatherModel model) async {
    return await ApiServer.request(Method.put, '$baseUrl/father/${model.id}',
        data: model.toJson());
  }
}
