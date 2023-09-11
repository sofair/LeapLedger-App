class TransactionModel {
  late int id;
  late int accountId;
  late int categoryId;
  late String incomseExpense;
  late String remark;
  late DateTime tradeTime;
  TransactionModel(this.id, this.accountId, this.categoryId,
      this.incomseExpense, this.remark, this.tradeTime);
  TransactionModel.fromResponse(Map<String, dynamic> responseData) {
    id = responseData['id'] ?? 0;
    accountId = responseData['account_id'] ?? 0;
    categoryId = responseData['category_id'] ?? 0;
    incomseExpense = responseData['incomse_expense'] ?? '';
    remark = responseData['remark'] ?? '';
    tradeTime = DateTime.fromMillisecondsSinceEpoch(
        (responseData['trade_time'] ?? 0) * 1000);
  }
}
