part of '../transaction_import.dart';

class PtcCard extends StatelessWidget {
  final List<MapEntry<TransactionCategoryFatherModel, List<TransactionCategoryModel>>> categoryTree;
  const PtcCard(this.categoryTree, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PtcCardBloc, PtcCardState>(builder: ((context, state) {
      if (state is PtcCardLoad) {
        return Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
          margin: EdgeInsets.zero,
          child: Column(children: [
            GridView.builder(
                shrinkWrap: true, // 让网格视图适应内容大小
                physics: const NeverScrollableScrollPhysics(), // 禁止滚动
                padding: EdgeInsets.zero,
                itemCount: state.ptcList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return buildItem(state.ptcList[index]);
                }),
            OutlinedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(const StadiumBorder(side: BorderSide(style: BorderStyle.none)))),
                onPressed: () {
                  var product = BlocProvider.of<PtcCardBloc>(context).product;
                  Object arguments = TransactionCategoryRoutes.getMappingPushArguments(
                    product,
                    categoryTree,
                    ptcList: state.ptcList,
                  );
                  Navigator.pushNamed(context, TransactionCategoryRoutes.mapping, arguments: arguments);
                },
                child: Text(
                  '设置交易类型关联',
                  style: TextStyle(
                    fontSize: Theme.of(context).primaryTextTheme.titleMedium!.fontSize,
                  ),
                ))
          ]),
        );
      }
      return const SizedBox(
        height: 300,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }));
  }

  Widget buildItem(ProductTransactionCategoryModel model) {
    return Chip(
        label: Text(
          model.name,
          style: const TextStyle(fontSize: 12),
        ),
        padding: const EdgeInsets.all(0),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero));
  }
}
