import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepaccount_app/common/global.dart';
import 'package:keepaccount_app/model/product/model.dart';
import 'package:keepaccount_app/model/transaction/category/model.dart';
import 'package:keepaccount_app/view/transaction/category/mapping/bloc/transaction_category_mapping_bloc.dart';
import 'package:keepaccount_app/widget/common/common.dart';
part 'weiget/header_card.dart';
part 'weiget/tab_view.dart';

class TransactionCategoryMapping extends StatelessWidget {
  final ProductModel product;
  late final List<MapEntry<TransactionCategoryFatherModel, List<TransactionCategoryModel>>> expenseCategoryTree;
  late final List<MapEntry<TransactionCategoryFatherModel, List<TransactionCategoryModel>>> incomeCategoryTree;
  late final List<ProductTransactionCategoryModel>? ptcList;
  TransactionCategoryMapping(
      this.product, List<MapEntry<TransactionCategoryFatherModel, List<TransactionCategoryModel>>> categoryTree,
      {this.ptcList, super.key}) {
    expenseCategoryTree = [];
    incomeCategoryTree = [];
    for (var element in categoryTree) {
      if (element.key.incomeExpense == IncomeExpense.income) {
        incomeCategoryTree.add(element);
      } else {
        expenseCategoryTree.add(element);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionCategoryMappingBloc>(
      create: (context) =>
          TransactionCategoryMappingBloc(product, ptcList: ptcList)..add(TransactionCategoryMappingLoadEvent()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("交易类型关联"),
              bottom: const TabBar(tabs: [
                Tab(text: "支出"),
                Tab(text: "收入"),
              ]),
            ),
            body: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey.shade200,
              child: TabBarView(
                children: [ExpenseTabView(expenseCategoryTree), IncomeTabView(incomeCategoryTree)],
              ),
            )),
      ),
    );
  }
}

class ExpenseTabView extends StatefulWidget {
  const ExpenseTabView(this.categoryTree, {super.key});
  final List<MapEntry<TransactionCategoryFatherModel, List<TransactionCategoryModel>>> categoryTree;

  @override
  State<ExpenseTabView> createState() => _ExpenseTabViewState();
}

class _ExpenseTabViewState extends State<ExpenseTabView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return TabView(IncomeExpense.expense, widget.categoryTree);
  }
}

class IncomeTabView extends StatefulWidget {
  const IncomeTabView(this.categoryTree, {super.key});
  final List<MapEntry<TransactionCategoryFatherModel, List<TransactionCategoryModel>>> categoryTree;

  @override
  State<IncomeTabView> createState() => _IncomeTabViewState();
}

class _IncomeTabViewState extends State<IncomeTabView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return TabView(IncomeExpense.income, widget.categoryTree);
  }
}
