import 'package:flutter/material.dart';

class TransactionTab extends StatefulWidget {
  @override
  _TransactionTabState createState() => _TransactionTabState();
}

class _TransactionTabState extends State<TransactionTab>
    with TickerProviderStateMixin {
  List<TabData> list = getData();
  final PageController _pageController = PageController(initialPage: 0);
  late TabController _tabController;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageView with TabBar'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: TabBar(
              tabs: List.generate(
                  list.length,
                  (index) => Text(list[index].title,
                      style: const TextStyle(color: Colors.black))),
              controller: _tabController,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
            ),
          ),
          Expanded(
            child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                    _tabController.animateTo(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  });
                },
                children: List.generate(
                    list.length,
                    (index) => Container(
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: list[index].list.length,
                          itemBuilder: (context, subIndex) {
                            return Row(children: [
                              Text(list[index].list[subIndex].name1),
                              Text(list[index].list[subIndex].name2)
                            ]);
                          },
                        )))),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _pageController.addListener(() {
      int currentIndex = _pageController.page!.round();
      if (currentIndex != _tabController.index) {
        _tabController.animateTo(currentIndex);
      }
    });
  }

  static List<TabData> getData() {
    return [
      TabData("示例1", Condition(type: "A", time: 2323), [
        ListData(name1: "B", name2: "test1"),
        ListData(name1: "B", name2: "test1"),
        ListData(name1: "B", name2: "test1")
      ]),
      TabData("示例2", Condition(type: "B", time: 2323), [
        ListData(name1: "B", name2: "test122"),
        ListData(name1: "C1", name2: "test123"),
        ListData(name1: "B1", name2: "test124")
      ]),
      TabData("示例3", Condition(type: "C", time: 2323), [
        ListData(name1: "B2", name2: "test122233"),
        ListData(name1: "C3", name2: "test122234"),
        ListData(name1: "d3", name2: "test122235")
      ]),
    ];
  }
}

class TabData {
  String title;
  Condition condition;
  List<ListData> list;
  TabData(this.title, this.condition, this.list);
}

class ListData {
  String name1, name2;
  ListData({required this.name1, required this.name2});
}

class Condition {
  String type;
  int time;
  Condition({required this.type, required this.time});
}
