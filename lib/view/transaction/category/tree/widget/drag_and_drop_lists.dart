part of '../transaction_category_tree.dart';

class _DragAndDropLists extends StatefulWidget {
  final IncomeExpense incomeExpense;
  const _DragAndDropLists(this.incomeExpense, {Key? key}) : super(key: key);

  @override
  _DragAndDropListsState createState() => _DragAndDropListsState();
}

class _DragAndDropListsState extends State<_DragAndDropLists> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    BlocProvider.of<TransactionCategoryTreeBloc>(context).add(LoadEvent(widget.incomeExpense));
    super.initState();
  }

  bool addFather(int index) {
    if (DefaultTabController.of(context).index == index) {
      TransactionCategoryFatherModel model = TransactionCategoryFatherModel.fromJson({})
        ..incomeExpense = widget.incomeExpense;
      Navigator.of(context).pushNamed(TransactionCategoryRoutes.fatherEdit,
          arguments: {'transactionCategoryFather': model}).then((value) {
        if (value is TransactionCategoryFatherModel && value.id > 0) {
          BlocProvider.of<TransactionCategoryTreeBloc>(context).add(AddFatherEvent(value));
        }
      });
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TransactionCategoryTreeBloc, TransactionCategoryTreeState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return buildShimmerList();
        } else if (state is LoadedState) {
          return _buildDragAndDropLists(state.list);
        }
        return Container();
      },
    );
  }

  _onItemReorder(int oldChildIndex, int oldFatherIndex, int newChildIndex, int newFatherIndex) {
    BlocProvider.of<TransactionCategoryTreeBloc>(context)
        .add(MoveChildEvent(oldChildIndex, oldFatherIndex, newChildIndex, newFatherIndex));
  }

  _onListReorder(int oldFatherIndex, int newFatherIndex) {
    BlocProvider.of<TransactionCategoryTreeBloc>(context).add(MoveFatherEvent(oldFatherIndex, newFatherIndex));
  }

  _buildDragAndDropLists(List<CategoryData> list) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: DragAndDropLists(
          children: List.generate(list.length, (index) => _buildList(list[index].father, list[index].children)),
          onItemReorder: _onItemReorder,
          onListReorder: _onListReorder,
          listPadding: const EdgeInsets.only(top: 8),
          listGhost: Container(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 100.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(),
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
          listDecoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          itemDivider: const Divider(height: 1, indent: 5, endIndent: 5),
          contentsWhenEmpty: const Text("快来设置交易类型！")),
    );
  }

  DragAndDropListExpansion _buildList(TransactionCategoryFatherModel father, List<TransactionCategoryModel> children) {
    return DragAndDropListExpansion(
        initiallyExpanded: true,
        disableTopAndBottomBorders: true,
        title: Text(father.name),
        trailing: Material(
            color: Colors.transparent, // 设置 Material 的颜色为透明
            child: _actionButtons(() => _updateFather(father), () => _deleteFather(father))),
        // subtitle: Text('Subtitle ${innerList.name}'),
        // leading: const Icon(Icons.ac_unit),
        children: List.generate(children.length, (index) => _buildChild(children[index])),
        listKey: ObjectKey(father),
        lastTarget: Center(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: TextButton(
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.add_circle_outline, size: 16), Text("创建子类型", style: TextStyle(fontSize: 16))],
                  ),
                  onPressed: () {
                    //添加子类型
                    Navigator.of(context).pushNamed(TransactionCategoryRoutes.edit, arguments: {
                      'transactionCategory': TransactionCategoryModel.fromJson({})
                        ..fatherId = father.id
                        ..incomeExpense = father.incomeExpense
                    }).then((value) {
                      if (value is TransactionCategoryModel && value.id > 0) {
                        BlocProvider.of<TransactionCategoryTreeBloc>(context).add(AddChildEvent(value));
                      }
                    });
                  },
                ))),
        contentsWhenEmpty: const SizedBox(height: 1));
  }

  _buildChild(TransactionCategoryModel child) {
    return DragAndDropItem(
      child: Material(
          color: Colors.transparent,
          child: ListTile(
              title: Text(child.name), trailing: _actionButtons(() => _updateChild(child), () => _deleteChild(child)))),
    );
  }

  _updateFather(TransactionCategoryFatherModel fahter) {
    //编辑
    Navigator.pushNamed(context, TransactionCategoryRoutes.fatherEdit, arguments: {'transactionCategoryFather': fahter})
        .then((value) {
      if (value is TransactionCategoryFatherModel) {
        BlocProvider.of<TransactionCategoryTreeBloc>(context).add(UpdateFatherEvent(value));
      }
    });
  }

  _updateChild(TransactionCategoryModel child) {
    //编辑
    Navigator.pushNamed(context, TransactionCategoryRoutes.edit, arguments: {'transactionCategory': child})
        .then((value) {
      if (value is TransactionCategoryModel) {
        BlocProvider.of<TransactionCategoryTreeBloc>(context).add(UpdateChildEvent(value));
      }
    });
  }

  _deleteFather(TransactionCategoryFatherModel fahter) {
    showDeleteConfirmationDialog(context, () {
      BlocProvider.of<TransactionCategoryTreeBloc>(context).add(DeleteFatherEvent(fahter.id));
    });
  }

  _deleteChild(TransactionCategoryModel child) {
    showDeleteConfirmationDialog(context, () {
      BlocProvider.of<TransactionCategoryTreeBloc>(context).add(DeleteChildEvent(child.id));
    });
  }

  _actionButtons(Function updateFunc, Function deleteFunc) {
    return Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => updateFunc(),
            icon: const Icon(Icons.edit),
          ),
          const SizedBox(width: 5),
          IconButton(
            onPressed: () => deleteFunc(),
            icon: const Icon(Icons.delete),
          )
        ]);
  }
}
