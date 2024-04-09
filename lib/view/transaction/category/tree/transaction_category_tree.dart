import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepaccount_app/bloc/user/user_bloc.dart';

import 'package:keepaccount_app/common/global.dart';
import 'package:keepaccount_app/model/account/model.dart';
import 'package:keepaccount_app/model/transaction/category/model.dart';
import 'package:keepaccount_app/routes/routes.dart';
import 'package:keepaccount_app/view/transaction/category/father/edit/transaction_category_father_edit_dialog.dart';

import 'package:keepaccount_app/view/transaction/category/tree/bloc/transaction_category_tree_bloc.dart';
import 'package:keepaccount_app/widget/common/common.dart';
part 'widget/drag_and_drop_lists.dart';

class TransactionCategoryTree extends StatefulWidget {
  final AccountDetailModel account;
  final AccountDetailModel? relatedAccount;
  const TransactionCategoryTree({super.key, required this.account, required this.relatedAccount});

  @override
  State<TransactionCategoryTree> createState() => _TransactionCategoryTreeState();
}

class _TransactionCategoryTreeState extends State<TransactionCategoryTree> with SingleTickerProviderStateMixin {
  final expenseKey = GlobalKey<_DragAndDropListsState>();
  final incomeKey = GlobalKey<_DragAndDropListsState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('交易类型'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: '支出'), Tab(text: '收入')],
        ),
        actions: [
          Offstage(
            offstage: false == widget.account.isCreator,
            child: IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () => onAddAction()),
          ),
          Offstage(
            offstage: widget.relatedAccount == null ||
                !TransactionCategoryRouterGuard.accountMapping(
                    parentAccount: widget.account, childAccount: widget.relatedAccount!),
            child: TextButton(
              child: const Text("关联交易"),
              onPressed: () => TransactionCategoryRoutes.accountMapping(
                context,
                parentAccount: widget.account,
                childAccount: widget.relatedAccount!,
              ).push(),
            ),
          )
        ],
      ),
      body: PageStorage(
        bucket: PageStorageBucket(),
        child: TabBarView(
          controller: _tabController,
          children: [
            BlocProvider<TransactionCategoryTreeBloc>(
              create: (context) => TransactionCategoryTreeBloc(account: widget.account),
              child: _DragAndDropLists(incomeExpense: IncomeExpense.expense, key: expenseKey),
            ),
            BlocProvider<TransactionCategoryTreeBloc>(
              create: (context) => TransactionCategoryTreeBloc(account: widget.account),
              child: _DragAndDropLists(incomeExpense: IncomeExpense.income, key: incomeKey),
            ),
          ],
        ),
      ),
    );
  }

  onAddAction() {
    if (expenseKey.currentState != null && _tabController.index == 0) {
      expenseKey.currentState!.addFather();
      return;
    } else if (incomeKey.currentState != null && _tabController.index == 1) {
      incomeKey.currentState!.addFather();
      return;
    }
  }
}
