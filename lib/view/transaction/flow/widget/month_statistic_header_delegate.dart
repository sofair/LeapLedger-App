part of 'enter.dart';

class MonthStatisticHeaderDelegate extends SliverPersistentHeaderDelegate {
  const MonthStatisticHeaderDelegate(this.data);

  final IncomeExpenseStatisticApiModel data;
  static TextStyle amountStyle = const TextStyle(color: Colors.black, fontSize: 16);
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        padding: const EdgeInsets.all(Constant.padding),
        decoration: const BoxDecoration(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(Constant.radius), topRight: Radius.circular(Constant.radius)),
          color: Colors.white,
        ),
        child: BlocBuilder<FlowListBloc, FlowListState>(
          builder: (context, state) {
            if (state is! FlowListLoading) {
              return _buildWidget();
            }
            return Shimmer.fromColors(
              baseColor: ConstantColor.shimmerBaseColor,
              highlightColor: ConstantColor.shimmerHighlightColor,
              child: _buildWidget(),
            );
          },
        ));
  }

  _buildWidget() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat("M月").format(data.startTime ?? DateTime.now()),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(DateFormat("yyyy").format(data.startTime ?? DateTime.now()))
                ],
              ),
            ),
            Expanded(
                flex: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildItem(const Text("收入："), data.income.amount),
                        buildItem(const Text("支出："), data.expense.amount),
                      ],
                    ),
                    const SizedBox(
                      width: Constant.padding,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildItem(const Text("结余："), data.income.amount - data.expense.amount),
                        buildItem(const Text("日均支出："), data.dayAverageExpense),
                      ],
                    ),
                  ],
                )),
          ],
        ),
        const SizedBox(
          height: Constant.margin,
        ),
        ConstantWidget.divider.list
      ],
    );
  }

  buildItem(Text text, int amount) {
    return Row(
      children: [
        text,
        SameHightAmount(
          amount: amount,
          textStyle: const TextStyle(color: Colors.black, fontSize: 12),
        )
      ],
    );
  }

  @override
  double get maxExtent => 44.5 + Constant.padding * 2 + Constant.margin;

  @override
  double get minExtent => 44.5 + Constant.padding * 2 + Constant.margin;
  @override
  bool shouldRebuild(covariant MonthStatisticHeaderDelegate oldDelegate) => data != oldDelegate.data;
}
