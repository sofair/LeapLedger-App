part of 'api_server.dart';

class AccountApi {
  static String baseUrl = "/account";
  static Future<List<AccountDetailModel>> getList() async {
    ResponseBody response = await ApiServer.request(Method.get, '$baseUrl/list');
    List<AccountDetailModel> result = [];
    if (response.isSuccess) {
      for (Map<String, dynamic> data in response.data['List']) {
        result.add(AccountDetailModel.fromJson(data));
      }
    }
    return result;
  }

  static Future<List<T>> getListByType<T extends AccountModel>({required AccountType type}) async {
    ResponseBody response = await ApiServer.request(Method.get, '$baseUrl/list/${type.name}');
    List<T> result = [];
    if (response.isSuccess) {
      for (Map<String, dynamic> data in response.data['List']) {
        result.add(AccountModel.fromJsonByType<T>(data));
      }
    }
    return result;
  }

  static Future<AccountModel> getOne(int id) async {
    ResponseBody response = await ApiServer.request(Method.get, '$baseUrl/$id');
    return AccountModel.fromJson(response.data);
  }

  static Future<AccountDetailModel?> add(AccountModel accountModel) async {
    ResponseBody responseBody = await ApiServer.request(Method.post, baseUrl, data: accountModel.toJson());
    if (false == responseBody.isSuccess) {
      return null;
    }
    return AccountDetailModel.fromJson(responseBody.data);
  }

  static Future<UserCurrentModel?> delete(int id) async {
    ResponseBody response = await ApiServer.request(Method.delete, '$baseUrl/$id');
    UserCurrentModel? userCurrent;
    if (response.isSuccess) {
      userCurrent = UserCurrentModel.fromJson(response.data);
    }
    return userCurrent;
  }

  static Future<ResponseBody> update(AccountModel accountModel) async {
    ResponseBody response =
        await ApiServer.request(Method.put, '$baseUrl/${accountModel.id}', data: accountModel.toJson());
    return response;
  }

  static Future<List<AccountTemplateModel>> getTemplateList() async {
    ResponseBody response = await ApiServer.request(Method.get, '$baseUrl/template/list');
    List<AccountTemplateModel> result = [];
    if (response.isSuccess) {
      for (Map<String, dynamic> data in response.data['List']) {
        result.add(AccountTemplateModel.fromJson(data));
      }
    }
    return result;
  }

  static Future<AccountDetailModel> addAccountByTempalte(AccountTemplateModel model) async {
    ResponseBody response = await ApiServer.request(Method.post, '$baseUrl/form/template/${model.id}');
    AccountDetailModel result;
    if (response.isSuccess) {
      result = AccountDetailModel.fromJson(response.data);
    } else {
      result = AccountDetailModel.fromJson({});
    }
    return result;
  }

  static Future<AccountDetailModel?> initTransCategoryByTempalte({
    required AccountModel account,
    required AccountTemplateModel template,
  }) async {
    ResponseBody response = await ApiServer.request(Method.post, '$baseUrl/${account.id}/transaction/category/init',
        data: {'TemplateId': template.id});
    AccountDetailModel? result;
    if (response.isSuccess) {
      result = AccountDetailModel.fromJson(response.data);
    }
    return result;
  }

  static Future<AccountUserModel?> updateUser(
      {required int id, required int accountId, required AccountRole role}) async {
    ResponseBody response =
        await ApiServer.request(Method.put, '$baseUrl/$accountId/user/$id', data: {'Role': role.value});
    AccountUserModel? result;
    if (response.isSuccess) {
      result = AccountUserModel.fromJson(response.data);
    }
    return result;
  }

  static Future<List<AccountUserModel>> getUserList({required int id}) async {
    ResponseBody response = await ApiServer.request(Method.get, '$baseUrl/$id/user/list');
    List<AccountUserModel> result = [];
    if (response.isSuccess) {
      for (Map<String, dynamic> data in response.data['List']) {
        result.add(AccountUserModel.fromJson(data));
      }
    }
    return result;
  }

  static Future<
      ({
        InExStatisticModel? todayTransTotal,
        InExStatisticModel? currentMonthTransTotal,
        List<TransactionModel>? recentTrans,
      })> getUserInfo({required int id, required int accountId}) async {
    ResponseBody response = await ApiServer.request(Method.get, '$baseUrl/$accountId/user/$id/info', data: {
      "Types": ['todayTransTotal', 'currentMonthTransTotal', 'recentTrans']
    });
    InExStatisticModel? todayTotal;
    InExStatisticModel? monthTotal;
    List<TransactionModel>? recentTrans;
    if (response.isSuccess) {
      if (response.data['TodayTransTotal'] != null) {
        todayTotal = InExStatisticModel.fromJson(response.data['TodayTransTotal']);
      }
      if (response.data['CurrentMonthTransTotal'] != null) {
        monthTotal = InExStatisticModel.fromJson(response.data['CurrentMonthTransTotal']);
      }
      if (response.data['RecentTrans'] != null && response.data['RecentTrans'] is List) {
        recentTrans = [];
        for (Map<String, dynamic> data in response.data['RecentTrans']) {
          recentTrans.add(TransactionModel.fromJson(data));
        }
      }
    }
    return (
      todayTransTotal: todayTotal,
      currentMonthTransTotal: monthTotal,
      recentTrans: recentTrans,
    );
  }

  // 获取信息
  static Future<
      ({
        InExStatisticWithTimeModel? todayTransTotal,
        InExStatisticWithTimeModel? currentMonthTransTotal,
        List<TransactionModel>? recentTrans,
      })> getInfo({required int accountId, required List<InfoType> types}) async {
    ResponseBody response =
        await ApiServer.request(Method.get, '$baseUrl/$accountId/info', data: {"Types": types.toJson()});
    InExStatisticWithTimeModel? todayTotal;
    InExStatisticWithTimeModel? monthTotal;
    List<TransactionModel>? recentTrans;
    if (response.isSuccess) {
      if (response.data['TodayTransTotal'] != null) {
        todayTotal = InExStatisticWithTimeModel.fromJson(response.data['TodayTransTotal']);
      }
      if (response.data['CurrentMonthTransTotal'] != null) {
        monthTotal = InExStatisticWithTimeModel.fromJson(response.data['CurrentMonthTransTotal']);
      }
      if (response.data['RecentTrans'] != null && response.data['RecentTrans'] is List) {
        recentTrans = [];
        for (Map<String, dynamic> data in response.data['RecentTrans']) {
          recentTrans.add(TransactionModel.fromJson(data));
        }
      }
    }
    return (todayTransTotal: todayTotal, currentMonthTransTotal: monthTotal, recentTrans: recentTrans);
  }

  static Future<List<TransactionModel>> getRecentTrans({required int accountId}) async {
    ResponseBody response =
        await ApiServer.request(Method.get, '$baseUrl/$accountId/info/${InfoType.recentTrans.toJson()}');
    List<TransactionModel> recentTrans = [];
    if (response.isSuccess) {
      if (response.data['RecentTrans'] != null && response.data['RecentTrans'] is List) {
        for (Map<String, dynamic> data in response.data['RecentTrans']) {
          recentTrans.add(TransactionModel.fromJson(data));
        }
      }
    }
    return recentTrans;
  }

  // 邀请
  static Future<AccountUserInvitationModle?> addUserInvitation(
      {required int accountId, required int userId, required AccountRole role}) async {
    ResponseBody response = await ApiServer.request(
      Method.post,
      '$baseUrl/$accountId/user/invitation',
      data: {"Invitee": userId, "Role": role.value},
    );

    if (false == response.isSuccess) {
      return null;
    }
    return AccountUserInvitationModle.fromJson(response.data);
  }

  static Future<List<AccountUserInvitationModle>> getUserInvitation(
      {required int limit, required int offset, int? accountId, int? inviteeId}) async {
    ResponseBody response = await ApiServer.request(Method.get, '$baseUrl/user/invitation/list', data: {
      "AccountId": accountId,
      "Invitee": inviteeId,
      "Limit": limit,
      "Offset": offset,
    });
    List<AccountUserInvitationModle> result = [];
    if (response.isSuccess) {
      for (Map<String, dynamic> data in response.data['List']) {
        result.add(AccountUserInvitationModle.fromJson(data));
      }
    }
    return result;
  }

  static Future<List<AccountUserInvitationModle>> getMineUserInvitation(
      {required int limit, required int offset}) async {
    ResponseBody response = await ApiServer.request(Method.get, '$baseUrl/user/invitation/list', data: {
      "Invitee": UserBloc.user.id,
      "Limit": limit,
      "Offset": offset,
    });
    List<AccountUserInvitationModle> result = [];
    if (response.isSuccess) {
      for (Map<String, dynamic> data in response.data['List']) {
        result.add(AccountUserInvitationModle.fromJson(data));
      }
    }
    return result;
  }

  static Future<AccountUserInvitationModle?> acceptInvitation(int id) async {
    ResponseBody response = await ApiServer.request(Method.put, '$baseUrl/user/invitation/$id/accept');
    if (response.isSuccess) {
      return AccountUserInvitationModle.fromJson(response.data);
    }
    return null;
  }

  static Future<AccountUserInvitationModle?> refuseInvitation(int id) async {
    ResponseBody response = await ApiServer.request(Method.put, '$baseUrl/user/invitation/$id/refuse');
    if (response.isSuccess) {
      return AccountUserInvitationModle.fromJson(response.data);
    }
    return null;
  }

  /// 返回null表示失败
  static Future<AccountMappingModel?> getMapping({required int accountId}) async {
    ResponseBody response = await ApiServer.request(Method.get, '$baseUrl/$accountId/mapping');
    if (response.isSuccess && response.data.isNotEmpty) {
      return AccountMappingModel.fromJson(response.data);
    }
    return null;
  }

  /// 返回null表示失败
  static Future<AccountMappingModel?> createMapping({required int mainAccountId, required int relatedAccountId}) async {
    ResponseBody response =
        await ApiServer.request(Method.post, '$baseUrl/$mainAccountId/mapping', data: {"AccountId": relatedAccountId});
    if (response.isSuccess) {
      return AccountMappingModel.fromJson(response.data);
    }
    return null;
  }

  static Future<bool> deleteMapping({required int mappingId, required int accountId}) async {
    ResponseBody response = await ApiServer.request(Method.delete, '$baseUrl/$accountId/mapping/$mappingId');
    return response.isSuccess;
  }

  /// 返回null表示失败
  static Future<AccountMappingModel?> updateMapping({
    required int mappingId,
    required int accountId,
    required int relatedAccountId,
  }) async {
    ResponseBody response = await ApiServer.request(Method.put, '$baseUrl/$accountId/mapping/$mappingId',
        data: {"RelatedAccountId": relatedAccountId});
    if (response.isSuccess) {
      return AccountMappingModel.fromJson(response.data);
    }
    return null;
  }

  /// 返回null表示失败
  static Future<AccountUserConfigModel?> getAccountUserConfig({required int accountId}) async {
    ResponseBody response = await ApiServer.request(Method.get, '$baseUrl/$accountId/user/config', data: {"AccountId": accountId});
    if (response.isSuccess) {
      return AccountUserConfigModel.fromJson(response.data);
    }
    return null;
  }

  /// 返回null表示失败
  static Future<AccountUserConfigModel?> updateAccountUserConfigFlagStatus({
    required String flagName,
    required int accountId,
    required bool status,
  }) async {
    ResponseBody response = await ApiServer.request(Method.put, '$baseUrl/$accountId/user/config/flag/$flagName',
        data: {"AccountId": accountId, "Status": status});
    if (response.isSuccess) {
      return AccountUserConfigModel.fromJson(response.data);
    }
    return null;
  }
}
