part of 'enter.dart';

class ConditionBottomSheet extends StatefulWidget {
  const ConditionBottomSheet({super.key});

  @override
  State<ConditionBottomSheet> createState() => _ConditionBottomSheetState();
}

class _ConditionBottomSheetState extends State<ConditionBottomSheet> {
  List<MapEntry<TransactionCategoryFatherModel, List<TransactionCategoryModel>>> categoryData = [];
  late final GlobalKey<FormState> _formKey;
  @override
  void initState() {
    BlocProvider.of<FlowConditionBloc>(context).add(FlowConditionCategoryDataFetchEvent());
    _formKey = GlobalKey<FormState>();
    _initCondition(BlocProvider.of<FlowConditionBloc>(context).condition);
    super.initState();
  }

  late TransactionQueryConditionApiModel _condition;
  void _initCondition(TransactionQueryConditionApiModel data) {
    _condition = TransactionQueryConditionApiModel(
      accountId: data.accountId,
      categoryIds: data.categoryIds?.toSet(),
      userIds: data.userIds?.toSet(),
      incomeExpense: data.incomeExpense,
      endTime: data.endTime,
      startTime: data.startTime,
      maximumAmount: data.maximumAmount,
      minimumAmount: data.minimumAmount,
    );
    selectedCategory = _condition.categoryIds ?? {};
    selectedIncomeExpense = _condition.incomeExpense;
  }

  void _save() {
    if (_formKey.currentState != null) {
      _formKey.currentState!.save();
    }
    _condition.categoryIds = selectedCategory.isEmpty ? null : selectedCategory;
    _condition.incomeExpense = selectedIncomeExpense;
    BlocProvider.of<FlowConditionBloc>(context).add(FlowConditionDataUpdateEvent(_condition));
    Navigator.of(context).pop();
  }

  void _reset() {
    setState(() {
      _initCondition(TransactionQueryConditionApiModel(
          accountId: _condition.accountId, startTime: _condition.startTime, endTime: _condition.endTime));
    });
  }

  bool _categoryLoad = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<FlowConditionBloc, FlowConditionState>(
      listener: (context, state) {
        if (state is FlowConditionCategoryLoaded) {
          setState(() {
            _categoryLoad = true;
            categoryData = state.tree;
          });
        }
      },
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.only(top: Constant.padding),
          decoration: ConstantDecoration.bottomSheet,
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 12,
                    child: SingleChildScrollView(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildOneConditon(name: "金额", _buildAmountInput()),
                        _buildOneConditon(name: "分类", [..._buildIncomeExpense(), ..._buildCategory()]),
                      ],
                    ))),
                //按钮
                Expanded(
                  child: _buildButtonGroup(),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildOneConditon(List<Widget> widgetList, {String? name}) {
    return Padding(
      padding: const EdgeInsets.all(Constant.padding),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: Constant.padding),
            child: Visibility(
              visible: name != null,
              child: Text(
                name ?? "",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          ...widgetList
        ],
      ),
    );
  }

  /// 金额
  List<Widget> _buildAmountInput() {
    return [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: AmountInput(
              onSave: (result) => _condition.minimumAmount = result,
              decoration: AmountInput.defaultDecoration.copyWith(labelText: "最低金额"),
            ),
          ),
          SizedBox(
            width: 32,
            child: Divider(
              color: Colors.grey.shade500,
              indent: 8,
              endIndent: 8,
              height: 0.5,
              thickness: 0.5,
            ),
          ), // Add some space between the text fields
          Flexible(
            child: AmountInput(
              onSave: (result) => _condition.maximumAmount = result,
              decoration: AmountInput.defaultDecoration.copyWith(labelText: "最高金额"),
            ),
          ),
        ],
      )
    ];
  }

  /// 收支
  IncomeExpense? selectedIncomeExpense;
  List<Widget> _buildIncomeExpense() {
    return [
      Padding(
        padding: const EdgeInsets.only(bottom: Constant.padding),
        child: SegmentedButton<IncomeExpense?>(
          selected: {selectedIncomeExpense},
          emptySelectionAllowed: true,
          showSelectedIcon: false,
          style: ButtonStyle(
            visualDensity: VisualDensity.compact,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(color: Colors.white),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return selectedIncomeExpense == IncomeExpense.income
                      ? ConstantColor.incomeAmount
                      : ConstantColor.expenseAmount;
                }
                return Colors.white;
              },
            ),
          ),
          onSelectionChanged: (value) {
            setState(() {
              selectedIncomeExpense = value.first;
            });
          },
          segments: const [
            ButtonSegment(
                value: IncomeExpense.income,
                label: Text(
                  "收入",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                )),
            ButtonSegment(
                value: IncomeExpense.expense,
                label: Text(
                  "支出",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ))
          ],
        ),
      ),
    ];
  }

  Set<int> selectedCategory = {};

  /// 交易类型
  List<Widget> _buildCategory() {
    return _categoryLoad == true
        ? List.generate(
            categoryData.length,
            (index) => _buildCategoryGroup(categoryData[index].key, categoryData[index].value),
          )
        : List.generate(
            categoryShimmerData.length,
            (index) => _buildCategoryGroup(categoryShimmerData[index].key, categoryShimmerData[index].value),
          );
  }

  _buildCategoryGroup(TransactionCategoryFatherModel father, List<TransactionCategoryModel> list) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: Constant.padding),
          child: Text(
            father.name,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        list.isNotEmpty
            ? GridView.builder(
                physics: const NeverScrollableScrollPhysics(), // 设置为不可滚动
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // 每行显示的项目数量
                  crossAxisSpacing: 12.0, // x轴间距
                  mainAxisSpacing: 0.0, // 主轴间距
                ),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return _buildCategoryIcon(list[index]);
                })
            : const Text("无"),
      ],
    );
  }

  Widget _buildCategoryIcon(TransactionCategoryModel category) {
    Color color = selectedCategory.contains(category.id) ? ConstantColor.primaryColor : Colors.black54;
    return GestureDetector(
      onTap: () => _onTapCategrop(category),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            category.icon,
            size: 32,
            color: color,
          ),
          Text(
            category.name,
            style: TextStyle(color: color, fontSize: 14),
          )
        ],
      ),
    );
  }

  _onTapCategrop(TransactionCategoryModel category) {
    setState(() {
      if (selectedCategory.contains(category.id)) {
        selectedCategory.remove(category.id);
      } else {
        selectedCategory.add(category.id);
      }
    });
  }

  /// 按钮组
  Widget _buildButtonGroup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            width: 100,
            child: OutlinedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(const StadiumBorder(side: BorderSide(style: BorderStyle.none)))),
              onPressed: () {
                _reset();
              },
              child: const Text(
                "重 置",
              ),
            )),
        SizedBox(
          width: 100,
          child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(const StadiumBorder(side: BorderSide(style: BorderStyle.none)))),
            onPressed: () {
              _save();
            },
            child: const Text(
              "确 定",
            ),
          ),
        )
      ],
    );
  }

  final List<MapEntry<TransactionCategoryFatherModel, List<TransactionCategoryModel>>> categoryShimmerData = [
    MapEntry(TransactionCategoryFatherModel.fromJson({})..name = "****", [
      TransactionCategoryModel.fromJson({})..name = "**",
      TransactionCategoryModel.fromJson({})..name = "**",
      TransactionCategoryModel.fromJson({})..name = "**",
      TransactionCategoryModel.fromJson({})..name = "**",
    ]),
    MapEntry(TransactionCategoryFatherModel.fromJson({})..name = "****", [
      TransactionCategoryModel.fromJson({})..name = "**",
      TransactionCategoryModel.fromJson({})..name = "**",
    ])
  ];
}
