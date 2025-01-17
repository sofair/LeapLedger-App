import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:leap_ledger_app/common/global.dart';
import 'package:leap_ledger_app/model/account/model.dart';
import 'package:leap_ledger_app/util/enter.dart';
import 'package:leap_ledger_app/view/transaction/chart/cubit/enter.dart';
import 'package:leap_ledger_app/view/transaction/chart/widget/enter.dart';
import 'package:leap_ledger_app/widget/common/common.dart';
import 'package:leap_ledger_app/widget/date/enter.dart';

class TransactionChart extends StatefulWidget {
  const TransactionChart({super.key, required this.account, this.startDate, this.endDate});
  final AccountDetailModel account;
  final DateTime? startDate, endDate;
  @override
  State<TransactionChart> createState() => _TransactionChartState();
}

class _TransactionChartState extends State<TransactionChart> {
  int touchedIndex = -1;
  late final ExpenseChartCubit _expenseCubit;
  late final IncomeChartCubit _incomeCubit;
  @override
  void initState() {
    _expenseCubit = ExpenseChartCubit(
      account: widget.account,
      startDate: widget.startDate,
      endDate: widget.endDate,
    );
    _incomeCubit = IncomeChartCubit(
      account: widget.account,
      startDate: widget.startDate,
      endDate: widget.endDate,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          backgroundColor: ConstantColor.greyBackground,
          appBar: AppBar(
            titleSpacing: 0,
            title: const TabBar(tabs: <Widget>[
              Tab(child: Text('支出', softWrap: false, overflow: TextOverflow.clip)),
              Tab(child: Text('收入', softWrap: false, overflow: TextOverflow.clip)),
            ], dividerHeight: 0),
            actions: _buildAction(),
            automaticallyImplyLeading: true,
          ),
          body: TabBarView(
            children: <Widget>[
              BlocProvider<ExpenseChartCubit>.value(
                value: _expenseCubit,
                child: const ExpenseTab(),
              ),
              BlocProvider<IncomeChartCubit>.value(
                value: _incomeCubit,
                child: const IncomeTab(),
              ),
            ],
          ),
        ));
  }

  List<Widget> _buildAction() {
    return [
      DateButton(
        expenseDate: DateTimeRange(start: _expenseCubit.startDate, end: _expenseCubit.endDate),
        incomeDate: DateTimeRange(start: _incomeCubit.startDate, end: _incomeCubit.endDate),
        onExpenseDateChanged: ({required DateTime end, required DateTime start}) {
          _expenseCubit.updateDate(start: start, end: end);
          setState(() {});
        },
        onIncomeDateChanged: ({required DateTime end, required DateTime start}) {
          _incomeCubit.updateDate(start: start, end: end);
          setState(() {});
        },
      )
    ];
  }
}

class DateButton extends StatelessWidget {
  const DateButton({
    super.key,
    required this.expenseDate,
    required this.incomeDate,
    required this.onExpenseDateChanged,
    required this.onIncomeDateChanged,
  });

  final DateTimeRange expenseDate, incomeDate;
  final Function({required DateTime end, required DateTime start}) onExpenseDateChanged, onIncomeDateChanged;
  @override
  Widget build(BuildContext context) {
    var tabIndex = DefaultTabController.of(context).index;
    DateTime start, end;
    if (tabIndex == 0) {
      start = expenseDate.start;
      end = expenseDate.end;
    } else {
      start = incomeDate.start;
      end = incomeDate.end;
    }

    bool isFirstSecondOfMonth = start == DateTime(start.year, start.month, 1, 0, 0, 0);
    bool isLastSecondOfMonth = end == Time.getLastSecondOfMonth(date: end);
    late String text;
    if (isFirstSecondOfMonth && isLastSecondOfMonth) {
      if (start.year == end.year && start.month == end.month) {
        text = DateFormat.yM().format(start);
      } else if (start.month == 0 && end.month == 12) {
        text = DateFormat.y().format(start);
      } else {
        text = '${DateFormat.yM().format(start)} - ${DateFormat.yM().format(end)}';
      }
    } else {
      text = '${DateFormat.yMd().format(start)} - ${DateFormat.yMd().format(end)}';
    }

    return TextButton(
        onPressed: () async {
          var date = await showMonthOrDateRangePickerModalBottomSheet(
            context: context,
            initialValue: DateTimeRange(start: start, end: end),
          );
          if (date == null) {
            return;
          }
          if (tabIndex == 0) {
            onExpenseDateChanged(start: date.start, end: date.end);
          } else {
            onIncomeDateChanged(start: date.start, end: date.end);
          }
        },
        style: const ButtonStyle(side: WidgetStatePropertyAll(BorderSide(color: ConstantColor.greyButton))),
        child: Text(text));
  }
}

class ExpenseTab extends StatefulWidget {
  const ExpenseTab({super.key});

  @override
  State<ExpenseTab> createState() => _ExpenseTabState();
}

class _ExpenseTabState extends State<ExpenseTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final ExpenseChartCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<ExpenseChartCubit>(context)..load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async => await _cubit.load(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Constant.margin, vertical: Constant.margin),
          child: _buildContant(),
        ),
      ),
    );
  }

  Widget _buildContant() {
    return Column(
      children: [
        BlocBuilder<ExpenseChartCubit, ExpenseChartState>(
          buildWhen: (_, current) => current is ExpenseTotalLoaded,
          builder: (context, state) {
            if (_cubit.total == null) {
              return const SizedBox();
            }
            return CommonCard.withTitle(
                child: TotalHeader(
              data: _cubit.total!,
              type: IncomeExpense.expense,
              days: _cubit.days,
            ));
          },
        ),
        BlocBuilder<ExpenseChartCubit, ExpenseChartState>(
          buildWhen: (_, current) => current is ExpenseDayStatisticsLoaded,
          builder: (context, state) {
            if (_cubit.statistics.isEmpty) {
              return const SizedBox();
            }
            return CommonCard.withTitle(
              title: "趋势",
              child: AspectRatio(
                aspectRatio: 1.61,
                child: StatisticsLineChart(list: _cubit.statistics),
              ),
            );
          },
        ),
        BlocBuilder<ExpenseChartCubit, ExpenseChartState>(
          buildWhen: (_, current) => current is ExpenseCategoryRankLoaded,
          builder: (context, state) {
            if (_cubit.categoryRankingList == null) {
              return const SizedBox();
            }
            return CommonCard.withTitle(
              title: "分类",
              child: Column(children: [
                CategoryPieChart(_cubit.categoryRankingList!),
                if (_cubit.categoryRankingList!.isNotEmpty) CategoryAmountRank(_cubit.categoryRankingList!)
              ]),
            );
          },
        ),
        BlocBuilder<ExpenseChartCubit, ExpenseChartState>(
          buildWhen: (_, current) => current is ExpenseTransRankLoaded,
          builder: (context, state) {
            if (_cubit.transRankinglist.isEmpty) {
              return const SizedBox();
            }
            return CommonCard.withTitle(
              title: "支出排行",
              child: TransactionAmountRank(transLsit: _cubit.transRankinglist),
            );
          },
        ),
      ],
    );
  }
}

class IncomeTab extends StatefulWidget {
  const IncomeTab({super.key});

  @override
  State<IncomeTab> createState() => _IncomeTabState();
}

class _IncomeTabState extends State<IncomeTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late final IncomeChartCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<IncomeChartCubit>(context)..load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async => await _cubit.load(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Constant.margin, vertical: Constant.margin),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        BlocBuilder<IncomeChartCubit, IncomeChartState>(
          buildWhen: (_, current) => current is IncomeTotalLoaded,
          builder: (context, state) {
            if (_cubit.total == null) {
              return const SizedBox();
            }
            return CommonCard.withTitle(
                child: TotalHeader(
              data: _cubit.total!,
              type: IncomeExpense.income,
              days: _cubit.days,
            ));
          },
        ),
        BlocBuilder<IncomeChartCubit, IncomeChartState>(
          buildWhen: (_, current) => current is IncomeCategoryRankLoaded,
          builder: (context, state) {
            if (_cubit.categoryRankingList == null) {
              return const SizedBox();
            }
            return CommonCard.withTitle(
              title: "分类",
              child: Column(children: [
                CategoryPieChart(_cubit.categoryRankingList!),
                if (_cubit.categoryRankingList!.isNotEmpty) CategoryAmountRank(_cubit.categoryRankingList!)
              ]),
            );
          },
        ),
        BlocBuilder<IncomeChartCubit, IncomeChartState>(
          buildWhen: (_, current) => current is IncomeTransRankLoaded,
          builder: (context, state) {
            if (_cubit.transRankinglist.isEmpty) {
              return const SizedBox();
            }
            return CommonCard.withTitle(
              title: "收入排行",
              child: TransactionAmountRank(transLsit: _cubit.transRankinglist),
            );
          },
        ),
      ],
    );
  }
}
