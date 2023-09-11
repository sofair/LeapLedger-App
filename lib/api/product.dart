part of 'api_server.dart';

class ProductApi {
  static String baseUrl = '/transaction/import/product';
  static Future<ResponseBody> getList() async {
    ResponseBody response = await ApiServer.request(Method.get, '$baseUrl/list');

    return response;
  }

  static Future<ResponseBody> getTransactionCategory(String key) async {
    ResponseBody response = await ApiServer.request(Method.get, '$baseUrl/$key/transaction/category');

    return response;
  }

  static Future<ResponseBody> getCategorymappingTree(String productKey, {int? accountId}) async {
    accountId ??= UserBloc.currentAccount.id;
    ResponseBody response = await ApiServer.request(Method.get, '$baseUrl/category/mapping/tree',
        data: {'AccountId': accountId, 'ProductKey': productKey});
    return response;
  }

  static Future<ResponseBody> mappingTransactionCategory(
      TransactionCategoryModel transactionCategory, ProductTransactionCategoryModel productTransactionCategory) async {
    ResponseBody response = await ApiServer.request(
        Method.get, '$baseUrl/transaction/category/${productTransactionCategory.id}/mapping',
        data: {'CategoryId': transactionCategory.id});
    return response;
  }

  static Future<ResponseBody> deleteTransactionCategoryMapping(
      TransactionCategoryModel transactionCategory, ProductTransactionCategoryModel productTransactionCategory) async {
    ResponseBody response = await ApiServer.request(
        Method.get, '$baseUrl/transaction/category/${productTransactionCategory.id}/mapping',
        data: {'CategoryId': transactionCategory.id});
    return response;
  }

  static Future<ResponseBody> uploadBill(String productKey, String filePath) async {
    ResponseBody response = await ApiServer.request(Method.post, '$baseUrl/transaction/category/$productKey/mapping',
        data: FormData.fromMap({
          'file': await MultipartFile.fromFile(filePath),
        }));
    return response;
  }
}
