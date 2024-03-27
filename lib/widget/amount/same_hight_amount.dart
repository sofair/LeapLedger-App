part of 'enter.dart';

enum IncomeExpenseDisplayModel { color, symbols }

/// 弃用 改用 [AmountTextSpan.sameHeight]
class SameHightAmount extends StatelessWidget {
  final int amount;
  late final TextStyle _textStyle;
  final bool dollarSign;
  final IncomeExpense? incomeExpense;
  final IncomeExpenseDisplayModel? displayModel;
  late final String prefix;
  SameHightAmount(
      {super.key,
      required this.amount,
      TextStyle textStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      this.dollarSign = false,
      this.incomeExpense,
      this.displayModel}) {
    if (displayModel == IncomeExpenseDisplayModel.color) {
      prefix = "";
      if (incomeExpense == IncomeExpense.income) {
        _textStyle = textStyle.copyWith(color: ConstantColor.incomeAmount);
      } else if (incomeExpense == IncomeExpense.expense) {
        _textStyle = textStyle.copyWith(color: ConstantColor.expenseAmount);
      } else {
        _textStyle = textStyle;
      }
    } else if (displayModel == IncomeExpenseDisplayModel.symbols) {
      _textStyle = textStyle;
      if (incomeExpense == IncomeExpense.income) {
        prefix = "+";
      } else if (incomeExpense == IncomeExpense.expense) {
        prefix = "-";
      } else {
        prefix = "";
      }
    } else {
      _textStyle = textStyle;
      prefix = "";
    }
  }

  @override
  RichText build(BuildContext context) {
    double amountInDollars = amount / 100.0;
    String formattedAmount = amountInDollars.toStringAsFixed(2);
    List<String> parts = formattedAmount.split('.');
    return RichText(
      textScaler: MediaQuery.of(context).textScaler,
      text: TextSpan(
        text: prefix + (dollarSign ? '￥${parts[0]}' : parts[0]),
        style: _textStyle,
        children: [
          TextSpan(
            text: '.${parts[1]}',
            style: _textStyle,
          )
        ],
      ),
    );
  }
}
