import 'dart:io';

import 'package:keepaccount_app/common/global.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum ENV { dev, release }

class Current {
  static const String cacheKey = 'current';
  static late String token;
  static late int accountId;
  static late ENV env;
  static late PackageInfo packageInfo;
  static late String peratingSystem; //android ios window

  static init() async {
    packageInfo = await PackageInfo.fromPlatform();
    peratingSystem = Platform.operatingSystem;
    Map<String, dynamic> prefsData = Global.cache.getData(cacheKey);
    token = '';
    accountId = prefsData['accountId'] ?? 0;
  }

  static saveToCache() =>
      Global.cache.save(cacheKey, {'token': token, 'accountId': accountId});
}
