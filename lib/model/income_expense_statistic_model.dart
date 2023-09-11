import 'package:intl/intl.dart';

class IncomseExpenseStatisticModel {
  int income, expense, timestamp;
  late String formattedDate, formattedIncome, formattedExpense;
  IncomseExpenseStatisticModel(this.timestamp, this.income, this.expense) {
    formattedDate = DateFormat('yyyy-MM-dd')
        .format(DateTime.fromMillisecondsSinceEpoch(timestamp));
    formattedIncome = (income / 100).toStringAsFixed(2);
    formattedExpense = (expense / 100).toStringAsFixed(2);
  }
}
