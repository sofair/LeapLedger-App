import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:keepaccount_app/common/global.dart';
import 'package:keepaccount_app/model/transaction/category/model.dart';
import 'package:keepaccount_app/routes/routes.dart';

import 'package:keepaccount_app/view/transaction/category/tree/bloc/transaction_category_tree_bloc.dart';
import 'package:keepaccount_app/widget/common/common_shimmer.dart';
import 'package:keepaccount_app/widget/dialog.dart';
part 'widget/drag_and_drop_lists.dart';

class TransactionCategoryTree extends StatelessWidget {
  const TransactionCategoryTree({super.key});

  @override
  Widget build(BuildContext context) {
    _TransactionCategoryTab expenseTab =
        _TransactionCategoryTab(IncomeExpense.expense);
    _TransactionCategoryTab incomeTab =
        _TransactionCategoryTab(IncomeExpense.income);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: const Text('交易类型'),
              bottom: const TabBar(
                tabs: [Tab(text: '支出'), Tab(text: '收入')],
              ),
              actions: [
                IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      if (expenseTab.listKey.currentState != null &&
                          expenseTab.listKey.currentState!.addFather(0) ==
                              true) {
                        return;
                      }
                      if (incomeTab.listKey.currentState != null &&
                          incomeTab.listKey.currentState!.addFather(1) ==
                              true) {
                        return;
                      }
                    }),
              ]),
          body: PageStorage(
            bucket: PageStorageBucket(),
            child: TabBarView(
              children: [expenseTab, incomeTab],
            ),
          ),
        ));
  }
}

class _TransactionCategoryTab extends StatelessWidget {
  final IncomeExpense incomeExpense;
  final GlobalKey<_DragAndDropListsState> listKey =
      GlobalKey<_DragAndDropListsState>();
  _TransactionCategoryTab(this.incomeExpense);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionCategoryTreeBloc>(
        create: (context) => TransactionCategoryTreeBloc(),
        child: _DragAndDropLists(
          incomeExpense,
          key: listKey,
        ));
  }
}
