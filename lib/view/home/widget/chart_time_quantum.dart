part of '../home.dart';

class TimeQuantumStatistic extends StatelessWidget {
  const TimeQuantumStatistic({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TimeQuantumRow(FontAwesomeIcons.calendarMinus, "今日",
                    "2023年5月28日", 10000, 20000),
                const Divider(),
                _TimeQuantumRow(FontAwesomeIcons.calendarMinus, "昨日",
                    "2023年5月27日", 10000, 20000),
                const Divider(),
                _TimeQuantumRow(FontAwesomeIcons.calendarDays, "本周",
                    "5月22日-5月28日", 10000, 20000),
                const Divider(),
                _TimeQuantumRow(
                    Icons.public_outlined, "本月", "5月01日-5月28日", 10000, 20000),
              ],
            )));
  }
}

class _TimeQuantumRow extends StatelessWidget {
  final IconData icon;
  final String title, date;
  final int income, expense;

  _TimeQuantumRow(this.icon, this.title, this.date, this.income, this.expense);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.blueAccent,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "总支出",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 5),
                  AmountDisplay(
                    amount: expense,
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.red),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "总收入",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(width: 5),
                  AmountDisplay(
                    amount: income,
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
