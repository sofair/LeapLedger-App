import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:keepaccount_app/model/income_expense_statistic_model.dart';
import 'package:keepaccount_app/view/common/transactionTab.dart';
import 'package:keepaccount_app/view/home/bloc/home_bloc.dart';
import '../../../widget/amount_display.dart';
import 'package:fl_chart/fl_chart.dart';

import 'navigation/home_navigation.dart';
part 'widget/chart_time_quantum.dart';
part 'widget/chart_statistic_line_chart.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc(),
        child: Container(
            color: Colors.grey.shade100,
            child: ListView(
              children: <Widget>[
                const MonthStatistic(),
                const HomeNavigation(),
                const TimeQuantumStatistic(),
                StatisticLineChart(),
              ],
            )));
  }
}

class MonthStatistic extends StatelessWidget {
  const MonthStatistic({super.key});
  final int expense = 500050, income = 30000, average = 200;
  final TextStyle testStyle = const TextStyle(
    fontSize: 16.0,
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TransactionTab()),
          );
        },
        child: Card(
            margin: const EdgeInsets.all(10),
            color: Colors.blue[400],
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '本月支出',
                        style: testStyle,
                      ),
                      Material(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 3, 10, 5),
                          child: Text(
                            '5月1日-5月30日',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  AmountDisplay(
                    amount: expense,
                    textStyle: const TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                    ),
                    dollarSign: true,
                    tailReduction: false,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Row(
                      children: [
                        Text(
                          '本月收入',
                          style: testStyle,
                        ),
                        AmountDisplay(
                          amount: 10000,
                          dollarSign: true,
                          textStyle: testStyle,
                          tailReduction: false,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          '日均支出',
                          style: testStyle,
                        ),
                        AmountDisplay(
                          amount: 10000,
                          dollarSign: true,
                          textStyle: testStyle,
                          tailReduction: false,
                        )
                      ],
                    )
                  ]),
                ],
              ),
            )));
  }
}
