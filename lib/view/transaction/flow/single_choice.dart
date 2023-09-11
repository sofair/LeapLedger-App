part of 'transaction_flow.dart';

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  final Map<String, Widget> _children = {
    EXPENSE: const Text(
      '支出',
    ),
    INCOME: const Text(
      '收入',
    ),
  };
  String currentSelection = EXPENSE;
  Color selectedTextStyle = Colors.white;
  @override
  Widget build(BuildContext context) {
    return MaterialSegmentedControl(
      children: _children,
      selectionIndex: currentSelection,
      borderColor: Colors.grey.shade100,
      selectedColor: Colors.blue[200]!,
      unselectedColor: Colors.white,
      unselectedTextStyle: const TextStyle(color: Colors.black),
      selectedTextStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      borderWidth: 0,
      horizontalPadding: EdgeInsets.fromLTRB(5, 0, 10, 0),
      disabledChildren: [_children.length],
      onSegmentTapped: (index) {
        setState(() {
          currentSelection = index.toString();
        });
      },
    );
  }
}
