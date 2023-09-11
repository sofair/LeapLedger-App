part of '../home.dart';

class StatisticLineChart extends StatelessWidget {
  final List<IncomseExpenseStatisticModel> data = [
    IncomseExpenseStatisticModel(1684775232, 100, 200),
    IncomseExpenseStatisticModel(1684861632, 200, 200),
    IncomseExpenseStatisticModel(1684948032, 500, 300),
    IncomseExpenseStatisticModel(1685034432, 400, 200),
    IncomseExpenseStatisticModel(1685120832, 500, 200),
    IncomseExpenseStatisticModel(1685207232, 600, 200),
    IncomseExpenseStatisticModel(1685293643, 700, 200),
    IncomseExpenseStatisticModel(1684775232, 100, 200),
    IncomseExpenseStatisticModel(1684861632, 200, 200),
    IncomseExpenseStatisticModel(1684948032, 500, 300),
    IncomseExpenseStatisticModel(1685034432, 400, 200),
    IncomseExpenseStatisticModel(1685120832, 500, 200),
    IncomseExpenseStatisticModel(1685207232, 600, 200),
    IncomseExpenseStatisticModel(1685293643, 700, 200),
    IncomseExpenseStatisticModel(1684775232, 100, 200),
    IncomseExpenseStatisticModel(1684861632, 200, 200),
    IncomseExpenseStatisticModel(1684948032, 500, 300),
    IncomseExpenseStatisticModel(1685034432, 400, 200),
    IncomseExpenseStatisticModel(1685120832, 500, 200),
    IncomseExpenseStatisticModel(1685207232, 600, 200),
    IncomseExpenseStatisticModel(1685293643, 700, 200),
    IncomseExpenseStatisticModel(1684775232, 100, 200),
    IncomseExpenseStatisticModel(1684861632, 200, 200),
    IncomseExpenseStatisticModel(1684948032, 500, 300),
    IncomseExpenseStatisticModel(1685034432, 400, 200),
    IncomseExpenseStatisticModel(1685120832, 500, 200),
    IncomseExpenseStatisticModel(1685207232, 600, 200),
    IncomseExpenseStatisticModel(1685293643, 700, 200),
  ];

  StatisticLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "本月交易统计",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 200, // 设置高度为100
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(enabled: false),
                    gridData: FlGridData(
                      show: true,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey[300],
                          strokeWidth: 1,
                        );
                      },
                      drawVerticalLine: true,
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Colors.grey[300],
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (
                            value,
                            context,
                          ) {
                            return Text(value.toString(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ));
                          },
                          reservedSize: 40,
                          interval: 1000,
                        )),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, context) {
                              return Text(
                                  DateFormat('dd').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          data[value.toInt()].timestamp *
                                              1000)),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ));
                            },
                            interval: 5,
                          ),
                        ),
                        topTitles: AxisTitles(),
                        rightTitles: AxisTitles()),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: data
                            .asMap()
                            .map((index, value) => MapEntry(
                                  index,
                                  FlSpot(index.toDouble(),
                                      value.income.toDouble()),
                                ))
                            .values
                            .toList(),
                        isCurved: true,
                        color: Colors.green,
                        barWidth: 2,
                        dotData: FlDotData(show: false),
                      ),
                      LineChartBarData(
                        spots: data
                            .asMap()
                            .map((index, value) => MapEntry(
                                  index,
                                  FlSpot(index.toDouble(),
                                      value.expense.toDouble()),
                                ))
                            .values
                            .toList(),
                        isCurved: true,
                        color: Colors.red,
                        barWidth: 2,
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
