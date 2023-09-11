class User {
  late int id;
  late int currentAccountId;
  User(this.id, this.currentAccountId);
  User.fromJson(dynamic data) {
    if (data.runtimeType == Map<String, dynamic>) {
      id = int.parse(data['id']);
      currentAccountId = int.parse(data['current_account_id']);
    } else {
      throw Exception("类型错误");
    }
  }
}
