part of 'api_server.dart';

class AccountApi {
  static Future<List<AccountModel>> getList() async {
    ResponseBody response =
        await ApiServer.request(Method.get, '/account/list');
    List<AccountModel> result = [];
    if (response.isSuccess) {
      for (Map<String, dynamic> data in response.data['List']) {
        result.add(AccountModel.fromJson(data));
      }
    }
    return result;
  }

  static Future<AccountModel> getOne(int id) async {
    ResponseBody response = await ApiServer.request(Method.get, '/account/$id');
    return AccountModel.fromJson(response.data);
  }

  static Future<ResponseBody> add(AccountModel accountModel) async {
    ResponseBody response = await ApiServer.request(Method.post, '/account',
        data: accountModel.toJson());
    accountModel.id = response.data['Id'];
    accountModel.createdAt = dateTimeFromJson(response.data['CreatedAt']);
    accountModel.updatedAt = dateTimeFromJson(response.data['UpdatedAt']);
    return response;
  }

  static Future<ResponseBody> delete(int id) async {
    ResponseBody response =
        await ApiServer.request(Method.delete, '/account/$id');
    return response;
  }

  static Future<ResponseBody> update(AccountModel accountModel) async {
    ResponseBody response = await ApiServer.request(
        Method.put, '/account/${accountModel.id}',
        data: accountModel.toJson());
    return response;
  }
}



// Future<List<AccountModel>> getOne(int id) async {
//   Response response = await request('/account/$id', Method.get);
//   List<AccountModel> result = [];
//   for (Map<String, dynamic> data in response.data['list']) {
//     result.add(AccountModel.fromResponse(data));
//   }
//   return result;
// }
