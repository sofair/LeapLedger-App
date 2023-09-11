part of 'api_server.dart';

class UserApi {
  static Future<ResponseBody> login(String account, String password) async {
    ResponseBody response = await ApiServer.request(
        Method.post, '/public/login',
        data: {'Username': account, 'Password': password});
    return response;
  }

  static Future<ResponseBody> setCurrentAccount(int accountId) async {
    ResponseBody response = await ApiServer.request(
        Method.put, '/user/client/current/account',
        data: {'Id': accountId});
    return response;
  }
}
