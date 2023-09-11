import 'dart:async';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../common/global.dart';

enum Method {
  post,
  get,
  put,
  delete,
}

const _headers = {
  'Content-Type': 'application/json',
  'x-token':
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJhY2NvdW50X2lkIjowLCJleHAiOjE2ODYzMjg5ODQsImlzcyI6InNlcnZlciIsInN1YiI6InVzZXIifQ.ZQPp6jHT3I-8pqKPqszZC8AZq8d5AvSlDW39y5gXwxk',
  'User-Agent': 'web-Web'
};
const int timeout = 5;

class Response {
  late String msg;
  late dynamic data;
  Response(String body) {
    var bodyMap = jsonDecode(body);
    if (bodyMap != null && bodyMap is Map<String, dynamic>) {
      msg = bodyMap['msg'];
      data = bodyMap['data'];
    } else {
      msg = '';
      data = null;
    }
  }
}

//请求和响应数据都是大驼峰命名法
Future<Response> request(String url, Method method,
    {Map<String, dynamic>? data}) async {
  print("request");
  http.Response response;
  Uri fullUrl;
  if (method == Method.get) {
    fullUrl = Uri.http(Global.config.server.network.address, url, data);
  } else {
    fullUrl = Uri.http(Global.config.server.network.address, url);
  }
  print(fullUrl.toString());
  if (data != null) {
    data.removeWhere((key, value) => value == null);
  }
  print(data);

  try {
    switch (method) {
      case Method.get:
        response = await http
            .get(fullUrl, headers: _headers)
            .timeout(const Duration(seconds: 5));
        break;
      case Method.post:
        response = await http
            .post(fullUrl, headers: _headers, body: jsonEncode(data))
            .timeout(const Duration(seconds: 5));
        break;
      case Method.put:
        response = await http
            .put(fullUrl, headers: _headers, body: jsonEncode(data))
            .timeout(const Duration(seconds: 5));
        break;
      case Method.delete:
        response = await http
            .delete(fullUrl, headers: _headers, body: jsonEncode(data))
            .timeout(const Duration(seconds: 5));
        break;
    }
    print(response.body);
  } on TimeoutException catch (_) {
    throw showErrorToast('请求超时');
  }
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return Response(response.body);
  } else {
    throw handleError(response);
  }
}

showErrorToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
  return RequestException(msg);
}

handleError(http.Response response) {
  print(response.body);
  if (response.statusCode == 404) {
    return showErrorToast("404 page not found");
  }
  try {
    var bodyMap = jsonDecode(response.body);
    if (bodyMap != null && bodyMap is Map<String, dynamic>) {
      return showErrorToast(bodyMap['msg']);
    }
  } on FormatException catch (_) {
    return showErrorToast(response.body);
  }
  return showErrorToast('服务器错误');
}

class RequestException implements Exception {
  String message;
  RequestException(this.message);

  @override
  String toString() {
    return message;
  }
}
