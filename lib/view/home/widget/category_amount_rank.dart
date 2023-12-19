part of 'enter.dart';

class CategoryAmountRank extends StatefulWidget {
  const CategoryAmountRank({super.key});

  @override
  State<CategoryAmountRank> createState() => _CategoryAmountRankState();
}

enum PageStatus { loading, expanding, contracting, noData }

class _CategoryAmountRankState extends State<CategoryAmountRank> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<TransactionCategoryAmountRankApiModel> _rankingList = [];
  List<TransactionCategoryAmountRankApiModel> presentData = [];
  final int initialQuantity = 3;
  PageStatus currentStatus = PageStatus.loading;
  int maxAmount = 0;
  initPresentData() {
    presentData = [];
    for (int index = 0; index < initialQuantity && index < _rankingList.length; index++) {
      presentData.add(_rankingList[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeCategoryAmountRank) {
          setState(() {
            currentStatus = PageStatus.contracting;
            _rankingList = state.rankingList;
            var first = _rankingList.firstOrNull;
            maxAmount = first != null ? first.amount : 0;
            initPresentData();
          });
        }
      },
      child: _Func._buildCard(
          title: "本月支出排行",
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                      children: List.generate(
                    presentData.length,
                    (index) => _buildListTile(presentData[index], index + 1),
                  )),
                ),
              ),
              _buildBottomContent(),
            ],
          )),
    );
  }

  _buildListTile(TransactionCategoryAmountRankApiModel data, int number) {
    return GestureDetector(
        onTap: () => _Func._pushTransactionFlow(
            context,
            TransactionQueryConditionApiModel(
                accountId: UserBloc.currentAccount.id,
                categoryIds: {data.category.id},
                startTime: HomeBloc.startTime,
                endTime: HomeBloc.endTime)),
        child: ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: Constant.padding),
                child: Text(
                  "$number",
                  style: const TextStyle(color: Colors.grey, fontSize: ConstantFontSize.headline),
                ),
              ),
              Icon(data.category.icon, color: ConstantColor.primaryColor)
            ],
          ),
          title: Text(
            data.category.name,
            style: const TextStyle(fontSize: ConstantFontSize.body),
          ),
          subtitle: data.amount != 0 ? AmountDivider(data.amount.toDouble() / maxAmount.toDouble()) : null,
          trailing: Padding(
            padding: EdgeInsets.zero,
            child: SameHightAmount(
              amount: data.amount,
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black87),
            ),
          ),
        ));
  }

  _buildBottomContent() {
    switch (currentStatus) {
      case PageStatus.loading:
        // 加载中状态
        return const Center(child: CircularProgressIndicator());
      case PageStatus.contracting:
        // 合起状态
        return TextButton(
          onPressed: () {
            //点击展开
            setState(() {
              currentStatus = PageStatus.expanding;
              presentData = _rankingList;
            });
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [Icon(Icons.keyboard_double_arrow_down_outlined, size: 19), Text("展开")],
          ),
        );
      case PageStatus.expanding:
        // 展开状态
        return TextButton(
          onPressed: () {
            //点击合并
            setState(() {
              currentStatus = PageStatus.contracting;
              initPresentData();
            });
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [Icon(Icons.keyboard_double_arrow_up_outlined, size: 19), Text("合起")],
          ),
        );
      default:
        return ConstantWidget.noTransactionDataText;
    }
  }
}

class AmountDivider extends StatelessWidget {
  final double proportion;
  const AmountDivider(this.proportion, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // 获取当前渲染的组件的宽度
        double currentWidth = constraints.maxWidth;

        return Divider(
            color: ConstantColor.secondaryColor,
            height: 0.5,
            thickness: 5,
            endIndent: currentWidth - currentWidth * proportion);
      },
    );
  }
}