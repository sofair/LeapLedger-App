part of 'enter.dart';

class TabView extends StatefulWidget {
  final IncomeExpense type;
  const TabView(this.type, {super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with AutomaticKeepAliveClientMixin {
  late final TransactionCategoryMappingBloc _bloc;

  List<MapEntry<TransactionCategoryFatherModel, List<TransactionCategoryModel>>> get tree =>
      widget.type == IncomeExpense.income ? _bloc.incomeCategoryTree : _bloc.expenseCategoryTree;

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    _bloc = BlocProvider.of<TransactionCategoryMappingBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TransactionCategoryMappingBloc, TransactionCategoryMappingState>(
      buildWhen: (TransactionCategoryMappingState oldState, TransactionCategoryMappingState newState) {
        if (widget.type == IncomeExpense.expense && newState is TransactionCategoryMappingExpenseLoaded) {
          return true;
        } else if (widget.type == IncomeExpense.income && newState is TransactionCategoryMappingIncomeLoaded) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is TransactionCategoryMappingLoaded) {
          return Container(
            padding: const EdgeInsets.all(Constant.padding),
            color: ConstantColor.greyBackground,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: HeaderCard(state.unmapped),
                ),
                buildList(state.relation),
              ],
            ),
          );
        }
        return const ShimmerList();
      },
    );
  }

  Widget buildList(
    Map<int, List<BaseTransactionCategoryModel>> relation,
  ) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (_, int index) => buildCategoryGroup(tree[index].key, tree[index].value, relation),
          childCount: tree.length),
    );
  }

  Widget buildCategoryGroup(
    TransactionCategoryFatherModel father,
    List<TransactionCategoryModel> childList,
    Map<int, List<BaseTransactionCategoryModel>> relation,
  ) {
    List<Widget> childrenWidget = [];

    for (var i = 0; i < childList.length; i++) {
      if (i != 0) childrenWidget.add(ConstantWidget.divider.list);
      childrenWidget.add(buildCategory(childList[i], relation[childList[i].id]));
    }
    return Padding(
      padding: const EdgeInsets.only(top: Constant.margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.all(Constant.margin), child: Text(father.name)),
          Container(
            padding: const EdgeInsets.all(Constant.padding),
            width: double.infinity,
            decoration: ConstantDecoration.cardDecoration,
            child: Column(
                mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: childrenWidget),
          )
        ],
      ),
    );
  }

  Widget buildCategory(
    TransactionCategoryModel category,
    List<BaseTransactionCategoryModel>? relation,
  ) {
    var textSize = (TextPainter(
            text: const TextSpan(text: "测试文字"),
            maxLines: 1,
            textScaler: MediaQuery.of(context).textScaler,
            textDirection: TextDirection.ltr)
          ..layout())
        .size;
    return ListTile(
        contentPadding: const EdgeInsets.all(0),
        minVerticalPadding: 0,
        dense: true,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: textSize.width, child: Center(child: Text(category.name))),
            const Icon(Icons.keyboard_double_arrow_left_outlined)
          ],
        ),
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: Constant.margin / 2,
          runSpacing: 0,
          children: List.generate(
              relation != null ? relation.length : 0,
              (index) => GestureDetector(
                  onTap: () => onDelete(category, relation[index]),
                  child: Chip(
                    label: Text(relation![index].name, style: const TextStyle(fontSize: ConstantFontSize.bodySmall)),
                    padding: const EdgeInsets.all(0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: ConstantDecoration.borderRadius,
                    ),
                    backgroundColor: ConstantColor.greyButton,
                  ))),
        ),
        trailing: GestureDetector(
          child: const Icon(Icons.add_circle_outline),
          onTap: () => onSelect(category),
        ));
  }

  _showCustomModalBottomSheet(
      BuildContext context, List<BaseTransactionCategoryModel> unmapped, TransactionCategoryModel model) async {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return OptionBottomSheet(unmapped: unmapped);
      },
    ).then((value) {
      if (value is BaseTransactionCategoryModel) {
        BlocProvider.of<TransactionCategoryMappingBloc>(context).add(TransactionCategoryMappingAddEvent(model, value));
      }
    });
  }

  onSelect(TransactionCategoryModel model) {
    _showCustomModalBottomSheet(context, _bloc.unmapped, model);
  }

  onDelete(TransactionCategoryModel category, BaseTransactionCategoryModel prc) {
    BlocProvider.of<TransactionCategoryMappingBloc>(context).add(TransactionCategoryMappingDeleteEvent(category, prc));
  }
}
