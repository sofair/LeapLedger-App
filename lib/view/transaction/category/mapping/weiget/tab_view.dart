part of '../transaction_category_mapping.dart';

class TabView extends StatelessWidget {
  final IncomeExpense type;
  final List<MapEntry<TransactionCategoryFatherModel, List<TransactionCategoryModel>>> categoryTree;
  const TabView(this.type, this.categoryTree, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCategoryMappingBloc, TransactionCategoryMappingState>(
      buildWhen: (TransactionCategoryMappingState oldState, TransactionCategoryMappingState newState) {
        if (type == IncomeExpense.expense && newState is TransactionCategoryMappingExpenseLoaded) {
          return true;
        } else if (type == IncomeExpense.income && newState is TransactionCategoryMappingIncomeLoaded) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is TransactionCategoryMappingLoaded) {
          onSelect(TransactionCategoryModel model) {
            _showCustomModalBottomSheet(context, state.unmapped, model);
          }

          onDelete(TransactionCategoryModel category, ProductTransactionCategoryModel prc) {
            BlocProvider.of<TransactionCategoryMappingBloc>(context)
                .add(TransactionCategoryMappingDeleteEvent(category, prc));
          }

          return CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: HeaderCard(state.unmapped),
              ),
              buildList(state.relation, onSelect, onDelete),
            ],
          );
        }
        return const ShimmerList();
      },
    );
  }

  Widget buildList(
    Map<int, List<ProductTransactionCategoryModel>> relation,
    Function(TransactionCategoryModel model) onSelect,
    Function(TransactionCategoryModel category, ProductTransactionCategoryModel prc) onDelete,
  ) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (_, int index) => buildCategoryGroup(
                categoryTree[index].key,
                categoryTree[index].value,
                relation,
                onSelect,
                onDelete,
              ),
          childCount: categoryTree.length),
    );
  }

  Widget buildCategoryGroup(
    TransactionCategoryFatherModel father,
    List<TransactionCategoryModel> childList,
    Map<int, List<ProductTransactionCategoryModel>> relation,
    Function(TransactionCategoryModel model) onSelect,
    Function(TransactionCategoryModel category, ProductTransactionCategoryModel prc) onDelete,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(father.name),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(childList.length, (index) {
                  var child = childList[index];
                  return buildCategory(
                    child,
                    relation[child.id],
                    onSelect,
                    onDelete,
                  );
                })),
          )
        ],
      ),
    );
  }

  Widget buildCategory(
    TransactionCategoryModel category,
    List<ProductTransactionCategoryModel>? relation,
    Function(TransactionCategoryModel model) onSelect,
    Function(TransactionCategoryModel category, ProductTransactionCategoryModel prc) onDelete,
  ) {
    return ListTile(
        contentPadding: const EdgeInsets.all(0),
        dense: true,
        leading: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(category.name), const Icon(Icons.keyboard_double_arrow_left_outlined)]),
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          children: relation != null
              ? List.generate(
                  relation.length,
                  (index) => GestureDetector(
                      onTap: () => onDelete(category, relation[index]),
                      child: Chip(
                          label: Text(
                            relation[index].name,
                            style: const TextStyle(fontSize: 12),
                          ),
                          padding: const EdgeInsets.all(0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: ConstantDecoration.borderRadius,
                          ),
                          backgroundColor: ConstantColor.greyButton)))
              : [],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: () => onSelect(category),
        ));
  }

  _showCustomModalBottomSheet(
      BuildContext context, List<ProductTransactionCategoryModel> unmapped, TransactionCategoryModel model) async {
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
                      child: Text(unmapped[index].name),
                    ),
                    onTap: () {
                      BlocProvider.of<TransactionCategoryMappingBloc>(context)
                          .add(TransactionCategoryMappingAddEvent(model, unmapped[index]));
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
                itemCount: unmapped.length,
              ),
            ));
      },
    );
  }
}
