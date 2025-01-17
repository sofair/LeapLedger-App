part of 'enter.dart';

class TimePeriodStatistics extends StatefulWidget {
  const TimePeriodStatistics({super.key, this.data});
  final UserHomeTimePeriodStatisticsApiModel? data;
  @override
  State<TimePeriodStatistics> createState() => _TimePeriodStatisticsState();
}

class _TimePeriodStatisticsState extends State<TimePeriodStatistics> {
  late UserHomeTimePeriodStatisticsApiModel data;
  late final HomeBloc _bloc;
  @override
  void initState() {
    _bloc = BlocProvider.of<HomeBloc>(context);
    initData();
    super.initState();
  }

  @override
  void didUpdateWidget(TimePeriodStatistics oldWidget) {
    if (widget.data != oldWidget.data) {
      initData();
    }
    super.didUpdateWidget(oldWidget);
  }

  void initData() {
    if (widget.data == null) {
      var today = Time.getFirstSecondOfDay(date: DateTime.now());
      data = UserHomeTimePeriodStatisticsApiModel(
        todayData: InExStatisticWithTimeModel(startTime: today, endTime: today),
        yearData: InExStatisticWithTimeModel(
          startTime: today.subtract(const Duration(days: 1)),
          endTime: today.subtract(const Duration(days: 1)),
        ),
        weekData: InExStatisticWithTimeModel(
          startTime: today.subtract(Duration(days: today.weekday - 1)),
          endTime: today.subtract(Duration(days: 7 - today.weekday)),
        ),
        yesterdayData: InExStatisticWithTimeModel(
          startTime: DateTime(today.year, 1, 1),
          endTime: DateTime(today.year + 1, 1, 1).subtract(const Duration(days: 1)),
        ),
      );
    } else {
      data = widget.data!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _Func._buildCard(
      title: "收支报告",
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constant.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildListTile(icon: Icons.calendar_today_outlined, title: "今日", data: data.todayData),
            ConstantWidget.divider.list,
            _buildListTile(icon: Icons.event_outlined, title: "昨日", data: data.yesterdayData),
            ConstantWidget.divider.list,
            _buildListTile(icon: Icons.date_range_outlined, title: "本周", data: data.weekData),
            ConstantWidget.divider.list,
            _buildListTile(icon: Icons.public_outlined, title: "今年", data: data.yearData),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({required IconData icon, required String title, required InExStatisticWithTimeModel data}) {
    String date;
    Function() onTap;
    TZDateTime startTime = _bloc.getTZDateTime(data.startTime);
    TZDateTime endTime = _bloc.getTZDateTime(data.endTime);

    if (Time.isSameDayComparison(startTime, endTime)) {
      date = DateFormat("yyyy年MM月dd日").format(startTime);
    } else {
      date = "${DateFormat("MM月dd日").format(startTime)}-${DateFormat("MM月dd日").format(endTime)}";
    }
    onTap = () {
      _Func._pushTransactionFlow(
        context,
        TransactionQueryCondModel(accountId: _bloc.account.id, startTime: startTime, endTime: endTime),
        _bloc.account,
      );
    };
    return GestureDetector(
        onTap: () => onTap(),
        child: SizedBox(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: Icon(
              icon,
              size: Constant.iconlargeSize,
              color: ConstantColor.primaryColor,
            ),
            title: Text(
              title,
              style: TextStyle(fontSize: ConstantFontSize.headline),
            ),
            subtitle: Text(
              date,
              style: TextStyle(fontSize: ConstantFontSize.bodySmall, color: ConstantColor.greyText),
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildEndAmount(name: "支", color: ConstantColor.expenseAmount, amount: data.expense.amount),
                _buildEndAmount(name: "收", color: ConstantColor.incomeAmount, amount: data.income.amount),
              ],
            ),
          ),
        ));
  }

  Widget _buildEndAmount({required String name, required Color color, required int amount}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AmountText.sameHeight(
          amount,
          textStyle: TextStyle(
            fontSize: ConstantFontSize.bodySmall,
            fontWeight: FontWeight.normal,
            color: color,
          ),
        ),
        SizedBox(width: Constant.margin / 2),
        Text(name, style: const TextStyle(color: ConstantColor.greyText)),
      ],
    );
  }
}
