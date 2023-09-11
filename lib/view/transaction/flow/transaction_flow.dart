import 'package:flutter/material.dart';
import 'package:keepaccount_app/common/global.dart';
import 'package:keepaccount_app/model/transaction_filter_model.dart';
import 'package:keepaccount_app/widget/amount_display.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
part 'single_choice.dart';

class TransactionFlow extends StatefulWidget {
  @override
  _TransactionFlowState createState() => _TransactionFlowState();
}

class _TransactionFlowState extends State<TransactionFlow> {
  List<Map<String, dynamic>> _transactionList = [
    {'type': '支出', 'amount': -20.0, 'time': DateTime.now().subtract(Duration(days: 1))},
    {'type': '收入', 'amount': 100.0, 'time': DateTime.now().subtract(Duration(days: 2))},
    {'type': '支出', 'amount': -50.0, 'time': DateTime.now().subtract(Duration(days: 3))},
    {'type': '收入', 'amount': 80.0, 'time': DateTime.now().subtract(Duration(days: 4))},
    {'type': '支出', 'amount': -30.0, 'time': DateTime.now().subtract(Duration(days: 5))},
    {'type': '收入', 'amount': 60.0, 'time': DateTime.now().subtract(Duration(days: 6))},
    {'type': '支出', 'amount': -20.0, 'time': DateTime.now().subtract(Duration(days: 1))},
    {'type': '收入', 'amount': 100.0, 'time': DateTime.now().subtract(Duration(days: 2))},
    {'type': '支出', 'amount': -50.0, 'time': DateTime.now().subtract(Duration(days: 3))},
    {'type': '收入', 'amount': 80.0, 'time': DateTime.now().subtract(Duration(days: 4))},
    {'type': '支出', 'amount': -30.0, 'time': DateTime.now().subtract(Duration(days: 5))},
    {'type': '收入', 'amount': 60.0, 'time': DateTime.now().subtract(Duration(days: 6))},
  ];
  final List<String> _parents = ['Parent 1', 'Parent 2', 'Parent 3'];

  final Map<String, List<String>> _children = {
    'Parent 1': ['Child 1-1', 'Child 1-2', 'Child 1-3'],
    'Parent 2': ['Child 2-1', 'Child 2-2', 'Child 2-3'],
    'Parent 3': ['Child 3-1', 'Child 3-2', 'Child 3-3']
  };
  List<String> _parentItems = [
    "Parent Item 1",
    "Parent Item 2",
    "Parent Item 3",
  ];
  Map<String, List<String>> _childItems = {
    "Parent Item 1": ["Child Item 1", "Child Item 2", "Child Item 3"],
    "Parent Item 2": ["Child Item 4", "Child Item 5"],
    "Parent Item 3": ["Child Item 6", "Child Item 7", "Child Item 8"],
  };
  Map<String, bool> _isExpanded = {};

  String _selectedFilter = '全部';
  final Map<String, bool> _expansionState = {};
  @override
  void initState() {
    super.initState();
    _parents.forEach((parent) {
      _expansionState[parent] = false;
    });
    // 初始化每个父项的展开状态为false
    for (int i = 0; i < _parentItems.length; i++) {
      _isExpanded[_parentItems[i]] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var totalIncome = _getTotalAmount('收入');
    var totalExpense = _getTotalAmount('支出');

    return CustomScrollView(slivers: [buildSliverAppBar(), buildSliverPersistentHeader(), buildList()]);
  }

  Widget buildList() {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.all(5),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.only(left: 5, top: 5),
            leading: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '5月',
                  style: TextStyle(fontSize: 24),
                ),
                Text('2023')
              ],
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('支出: ', style: TextStyle(fontSize: 17, color: Colors.grey.shade600)),
                const AmountDisplay(
                  amount: 10000,
                  textStyle: TextStyle(fontSize: 20, color: Colors.red),
                )
              ],
            ),
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('二级列表${index + 1}'),
                  );
                },
                itemCount: 5,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.all(5),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            leading: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '5月',
                  style: TextStyle(fontSize: 24),
                ),
                Text('2023')
              ],
            ),
            title: Row(
              children: [
                Text('支出', style: TextStyle(fontSize: 20, color: Colors.grey.shade500)),
                const AmountDisplay(
                  amount: 10000,
                  textStyle: TextStyle(fontSize: 24, color: Colors.red),
                )
              ],
            ),
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('二级列表${index + 1}'),
                  );
                },
                itemCount: 5,
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget _buildChildren(String parent) {
    return Column(
      children: _children[parent]!.map((child) => ListTile(title: Text(child))).toList(),
    );
  }

  Widget buildSliverAppBar() {
    String title = "本月统计";
    int totalIncome = 15300, totalExpense = 1533300;
    TextStyle labelStyle = TextStyle(fontSize: 14, color: Colors.grey.shade600);
    TextStyle titleStyle = TextStyle(fontSize: 14, color: Colors.grey.shade600);
    TextPainter painter = TextPainter(
      text: TextSpan(text: title, style: titleStyle),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    painter.layout();
    double textWeight = painter.width;
    return SliverAppBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: 17),
        textAlign: TextAlign.left,
      ),
      floating: true,
      pinned: true,
      expandedHeight: 120.0,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        centerTitle: true,
        collapseMode: CollapseMode.pin,
        background: Container(
            decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.grey.shade100],
          ),
        )),
        title: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          spacing: 5,
          runSpacing: 5,
          children: <Widget>[
            SizedBox(
              width: textWeight,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "总支出:",
                  style: labelStyle,
                ),
                AmountDisplay(
                  amount: totalExpense,
                  textStyle: const TextStyle(fontSize: 18, color: Colors.red),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  "总收入:",
                  style: labelStyle,
                ),
                AmountDisplay(
                  amount: totalIncome,
                  textStyle: const TextStyle(fontSize: 18, color: Colors.green),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSliverPersistentHeader() {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    const TextStyle menuItemTextStyle = TextStyle(color: Colors.lightBlue);
    final TransactionFilterModel filter =
        TransactionFilterModel(timeIntervalType: 'day', transactionCategoryType: 'father');

    return SliverPersistentHeader(
      pinned: true,
      delegate: _FilterDropdownDelegate(
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          height: 60,
          color: Colors.grey.shade100,
          child: Form(
              key: formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      width: 80,
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          hintText: '时间',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          border: InputBorder.none,
                          // Add other decoration properties as needed
                        ),
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 26,
                        style: const TextStyle(fontSize: 16, color: Colors.blue),
                        value: filter.timeIntervalType,
                        items: const [
                          DropdownMenuItem(value: 'day', child: Text('天', style: menuItemTextStyle)),
                          DropdownMenuItem(value: 'week', child: Text('周', style: menuItemTextStyle)),
                          DropdownMenuItem(value: 'month', child: Text('月', style: menuItemTextStyle)),
                          DropdownMenuItem(value: 'year', child: Text('年', style: menuItemTextStyle)),
                        ],
                        onChanged: (value) {
                          filter.timeIntervalType = value;
                        },
                      )),
                  SizedBox(
                      width: 100, // 设置容器宽度
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          hintText: '类别',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue), // 修改选中状态下划线颜色为蓝色
                          ),
                          border: InputBorder.none,
                          // Add other decoration properties as needed
                        ),
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 26,
                        value: filter.transactionCategoryType,
                        items: const [
                          DropdownMenuItem(value: 'father', child: Text('一级', style: menuItemTextStyle)),
                          DropdownMenuItem(value: 'children', child: Text('二级', style: menuItemTextStyle)),
                        ],
                        onChanged: (value) {
                          filter.transactionCategoryType = value;
                        },
                      )),
                  const SizedBox(width: 130, height: 45, child: SingleChoice()),
                ],
              )),
        ),
      ),
    );
  }

  double _getTotalAmount(String type) {
    var total = 0.0;
    for (var transaction in _transactionList) {
      if (transaction['type'] == type) {
        total += transaction['amount'];
      }
    }
    return total;
  }

  List<DropdownMenuItem<String>> _getFilterItems() {
    return ['全部', '收入', '支出'].map((e) => DropdownMenuItem<String>(child: Text(e), value: e)).toList();
  }

  String _formatTime(DateTime time) {
    return '${time.year}-${time.month}-${time.day}';
  }
}

class _FilterDropdownDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _FilterDropdownDelegate({required this.child});

  @override
  double get maxExtent => 56;

  @override
  double get minExtent => 56;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _FilterDropdownDelegate oldDelegate) {
    return false;
  }
}
