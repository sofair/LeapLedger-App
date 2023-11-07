import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepaccount_app/common/global.dart';
import 'package:keepaccount_app/model/product/model.dart';
import 'package:keepaccount_app/model/transaction/category/model.dart';
import 'package:keepaccount_app/util/enter.dart';
import 'package:keepaccount_app/view/transaction/import/bloc/trans_import_tab_bloc.dart';
import 'package:keepaccount_app/view/transaction/import/bloc/transaction_import_bloc.dart';
import 'package:keepaccount_app/widget/common/common_shimmer.dart';
import 'package:file_picker/file_picker.dart';
part 'widget/tab.dart';

class TransactionImport extends StatelessWidget {
  const TransactionImport({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransImportTabBloc>(
      create: (context) =>
          TransImportTabBloc()..add(TransImportTabLoadedEvent()),
      child: const _TransactionImport(),
    );
  }
}

class _TransactionImport extends StatelessWidget {
  const _TransactionImport();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransImportTabBloc, TransImportTabState>(
        builder: (context, state) {
      if (state is TransImportTabLoaded) {
        return buildPage(state);
      }
      return Scaffold(
          appBar: AppBar(title: const Text('导入账单')), body: buildShimmer());
    });
  }

  Widget buildPage(TransImportTabLoaded state) {
    return DefaultTabController(
        length: state.list.length,
        child: Scaffold(
            appBar: AppBar(
                title: const Text('导入账单'),
                bottom: TabBar(
                  tabs: state.list.map((e) => Tab(text: e.name)).toList(),
                )),
            body: PageStorage(
                bucket: PageStorageBucket(),
                child: TabBarView(
                    children: state.list
                        .map((e) => BlocProvider<TransactionImportBloc>(
                            create: (context) =>
                                TransactionImportBloc(e.uniqueKey),
                            child: _TransactionImportTab(state.tree)))
                        .toList()))));
  }
}
