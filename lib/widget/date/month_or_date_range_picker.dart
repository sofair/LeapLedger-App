part of 'enter.dart';

/// return中start会是日期那天的第一秒 end会是日期那天的最后一秒
Future<DateTimeRange?> showMonthOrDateRangePickerModalBottomSheet({
  required BuildContext context,
  required DateTimeRange initialValue,
}) async {
  return await showModalBottomSheet<DateTimeRange>(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) => MonthOrDateRangePicker(initialValue: initialValue),
  );
}

class MonthOrDateRangePicker extends StatefulWidget {
  const MonthOrDateRangePicker({required this.initialValue, super.key});
  final DateTimeRange initialValue;
  @override
  // ignore: library_private_types_in_public_api
  _MonthOrDateRangePickerState createState() => _MonthOrDateRangePickerState();
}

class _MonthOrDateRangePickerState extends State<MonthOrDateRangePicker> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);

    startDate = widget.initialValue.start;
    endDate = widget.initialValue.end;
    //判断是否是处在同一个月 并且起始和结束时间分别是月第一秒和最后一秒
    bool isFirstSecondOfMonth = startDate == DateTime(startDate.year, startDate.month, startDate.day, 0, 0, 0);
    bool isLastSecondOfMonth = endDate == DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
    if (isFirstSecondOfMonth &&
        isLastSecondOfMonth &&
        startDate.year == endDate.year &&
        startDate.month == endDate.month) {
      _tabController.index = _monthTabIndex;
    } else {
      _tabController.index = _dateRangeTabIndex;
    }

    endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
    startDate = DateTime(startDate.year, startDate.month, startDate.day, 0, 0, 0);
    month = DateTime(startDate.year, startDate.month, 1, 0, 0, 0);
  }

  late TabController _tabController;
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final int _monthTabIndex = 0, _dateRangeTabIndex = 1;
  DateTime startDate = DateTime.now(), endDate = DateTime.now(), month = DateTime.now();
  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TabBar(
          controller: _tabController,
          tabs: const [Tab(text: '月份选择'), Tab(text: '自定义时间')],
        ),
        Container(
          padding: const EdgeInsets.all(Constant.padding),
          child: [_buildMonthPicker(), _buildDateRangePicker()][_tabController.index],
        )
      ],
    );
  }

  /// 月份滚轮选择
  Widget _buildMonthPicker() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.monthYear,
              initialDateTime: month,
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  month = newDate;
                });
              },
            )),
        _buildSumbitButton(),
      ],
    );
  }

  void _initDateRangeButtonState() {
    datePickerKey = UniqueKey();
    selectedStartInputButton = true;
    selectedNumberOfMonths = null;
  }

  UniqueKey datePickerKey = UniqueKey();

  /// 自定义时间（日期范围选择）
  Widget _buildDateRangePicker() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SizedBox(
            height: 28,
            child: Wrap(
              spacing: Constant.margin,
              children: [
                _buildMonthButton(numberOfMonths: 3, name: '近三月'),
                _buildMonthButton(numberOfMonths: 6, name: '近六月'),
                _buildMonthButton(numberOfMonths: 12, name: '近一年'),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // 时间输入框
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: _buildInputButton(isStartInputButton: true),
            ),
            const Expanded(
                child: Padding(
              padding: EdgeInsets.all(Constant.margin),
              child: Divider(color: Colors.black87),
            )),
            Expanded(
              flex: 5,
              child: _buildInputButton(isStartInputButton: false),
            ),
          ],
        ),
        // 日期滚轮
        SizedBox(
          height: 300,
          child: CupertinoDatePicker(
            key: datePickerKey,
            mode: CupertinoDatePickerMode.date,
            initialDateTime: selectedStartInputButton ? startDate : endDate,
            minimumDate: selectedStartInputButton ? null : startDate,
            maximumDate: selectedStartInputButton ? endDate : null,
            minimumYear: 2000,
            maximumYear: 2050,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                if (selectedStartInputButton) {
                  startDate = newDate;
                } else {
                  endDate = newDate;
                }
              });
            },
          ),
        ),
        _buildSumbitButton()
      ],
    );
  }

  int? selectedNumberOfMonths = 0;

  /// 月份快捷按钮
  Widget _buildMonthButton({required int numberOfMonths, required String name}) {
    assert(numberOfMonths >= 1);
    var isSelected = selectedNumberOfMonths == numberOfMonths;
    return GestureDetector(
      onTap: () {
        setState(() {
          _initDateRangeButtonState();
          startDate = Time.getFirstSecondOfPreviousMonths(date: DateTime.now(), numberOfMonths: numberOfMonths - 1);
          endDate = Time.getLastSecondOfMonth();
          selectedNumberOfMonths = numberOfMonths;
        });
      },
      child: Container(
        width: 64,
        height: 28,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? ConstantColor.primaryColor : Colors.grey, // 设置边框颜色
            width: 1.0, // 设置边框宽度
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? ConstantColor.primaryColor : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  bool selectedStartInputButton = true;

  /// 输入框按钮
  Widget _buildInputButton({bool isStartInputButton = false}) {
    return GestureDetector(
      onTap: () => setState(() {
        _initDateRangeButtonState();
        selectedStartInputButton = isStartInputButton;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Constant.padding),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selectedStartInputButton == isStartInputButton ? ConstantColor.primaryColor : Colors.grey,
              width: 2.0,
            ),
          ),
        ),
        child: Center(
          child: Text(
            isStartInputButton ? DateFormat('yyyy-MM-dd').format(startDate) : DateFormat('yyyy-MM-dd').format(endDate),
            style: TextStyle(
              fontSize: 18,
              color: selectedStartInputButton == isStartInputButton ? ConstantColor.primaryColor : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  /// 提交按钮
  Widget _buildSumbitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () {
            DateTime start, end;
            if (_tabController.index == _monthTabIndex) {
              start = DateTime(month.year, month.month, 1, 0, 0, 0);
              end = Time.getLastSecondOfMonth(date: start);
            } else {
              start = DateTime(startDate.year, startDate.month, startDate.day, 0, 0, 0);
              end = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
            }
            Navigator.of(context).pop(DateTimeRange(start: start, end: end));
          },
          child: const Text('确定')),
    );
  }
}
