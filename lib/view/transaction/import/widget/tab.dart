part of '../transaction_import.dart';

class _TransactionImportTab extends StatefulWidget {
  final List<MapEntry<TransactionCategoryFatherModel, List<TransactionCategoryModel>>> tree;

  const _TransactionImportTab(this.tree);

  @override
  _TransactionImportTabState createState() => _TransactionImportTabState();
}

class _TransactionImportTabState extends State<_TransactionImportTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    BlocProvider.of<TransactionImportBloc>(context).add(TransactionImportLoadEvent());
    super.initState();
  }

  List<ProductTransactionCategoryModel> unmapped = [];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TransactionImportBloc, TransactionImportState>(
      builder: (context, state) {
        if (state is TransactionImportLoadedState) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: _buildListView(state),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildListView(TransactionImportLoadedState state) {
    unmapped = state.unmapped;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ListView.builder(
          shrinkWrap: true, // 防止ListView自身滚动
          itemCount: widget.tree.length + 3,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ElevatedButton(
                style: ButtonStyle(
                    // 设置圆角
                    shape: MaterialStateProperty.all(const StadiumBorder(side: BorderSide(style: BorderStyle.none)))),
                onPressed: () => _uploadBillFile(),
                child: Text('导入', style: Theme.of(context).primaryTextTheme.titleMedium),
              );
            }
            if (index == 1) {
              return _unmappedCategory(unmapped);
            }
            if (index == 2) {
              return const ListTile(
                title: Text(
                  "已关联交易类型",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
            var fatherModel = widget.tree[index - 3].key;
            var childModels = widget.tree[index - 3].value;
            return ExpansionTile(
              leading: fatherModel.incomeExpense == IncomeExpense.income
                  ? Text(
                      "收入",
                      style: TextStyle(color: Colors.green[100]),
                    )
                  : Text(
                      "支出",
                      style: TextStyle(color: Colors.red[100]),
                    ),
              title: Text(
                fatherModel.name,
                style: const TextStyle(fontSize: 18),
              ),
              children: _buildExpansionTileChildren(childModels, state.relation),
            );
          },
        ),
      ),
    );
  }

  void _uploadBillFile() async {
    await FileOperation.selectFile(FileType.custom, ['xls', 'xlsx', 'csv']).then((value) {
      if (value != null) {
        BlocProvider.of<TransactionImportBloc>(context).add(TransactionImportUploadBillEvent(value.path));
      }
    });
  }

  List<Widget> _buildExpansionTileChildren(
      List<TransactionCategoryModel> children, Map<int, List<ProductTransactionCategoryModel>> relation) {
    return children
        .map<Widget>((child) => ListTile(
            leading: child.incomeExpense == IncomeExpense.income
                ? Text(
                    "收入",
                    style: TextStyle(color: Colors.green[100]),
                  )
                : Text(
                    "支出",
                    style: TextStyle(color: Colors.red[100]),
                  ),
            title: Text(
              child.name,
              style: const TextStyle(fontSize: 16),
            ),
            trailing: IconButton(
              alignment: Alignment.centerRight,
              icon: const Icon(Icons.add),
              padding: const EdgeInsets.all(0),
              onPressed: () async {
                await _showCustomModalBottomSheet(child);
              },
            ),
            subtitle: _buildExpansionTileSubtitleWrap(relation[child.id])))
        .toList();
  }

  Widget? _buildExpansionTileSubtitleWrap(List<ProductTransactionCategoryModel>? children) {
    if (children != null) {
      return Wrap(
        spacing: 4.0,
        children: children.map((e) => _buildChip(e)).toList(),
      );
    }
    return null;
  }

  Widget _unmappedCategory(List<ProductTransactionCategoryModel> unmapped) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: const Text(
        '未关联交易类型',
        style: TextStyle(fontSize: 18),
      ),
      children: [
        Wrap(
            spacing: 4.0,
            children: unmapped.map((product) {
              return _buildChip(product);
            }).toList())
      ],
    );
  }

  Widget _buildChip(ProductTransactionCategoryModel product) {
    if (product.incomeExpense == IncomeExpense.income) {
      return Chip(label: Text(product.name), backgroundColor: Colors.green[100]);
    }
    return Chip(label: Text(product.name), backgroundColor: Colors.red[100]);
  }

  _showCustomModalBottomSheet(TransactionCategoryModel model) async {
    List<ProductTransactionCategoryModel> list = [];
    for (var element in unmapped) {
      if (element.incomeExpense == model.incomeExpense) {
        list.add(element);
      }
    }
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            height: MediaQuery.of(context).size.height / 2.0,
            child: Scrollbar(
              child: ListView.separated(
                itemBuilder: (_, int index) {
                  return ListTile(
                    title: Center(
                      child: Text(list[index].name),
                    ),
                    onTap: () {
                      BlocProvider.of<TransactionImportBloc>(context)
                          .add(TransactionImportMappingEvent(model, list[index]));
                      Navigator.pop(context);
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.grey,
                    height: 0.5,
                    thickness: 0.5,
                    indent: 16,
                    endIndent: 16,
                  );
                },
                itemCount: list.length,
              ),
            ));
      },
    );
  }
}
