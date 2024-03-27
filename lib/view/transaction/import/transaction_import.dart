import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepaccount_app/model/product/model.dart';
import 'package:keepaccount_app/model/transaction/category/model.dart';
import 'package:keepaccount_app/routes/routes.dart';
import 'package:keepaccount_app/util/enter.dart';

import 'package:file_picker/file_picker.dart';
import 'package:keepaccount_app/widget/common/common.dart';
import 'bloc/enter.dart';

part 'widget/ptc_card.dart';

class TransactionImport extends StatelessWidget {
  const TransactionImport({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransImportTabBloc>(
      create: (context) => TransImportTabBloc()..add(TransImportTabLoadedEvent()),
      child: const _TransactionImport(),
    );
  }
}

class _TransactionImport extends StatelessWidget {
  const _TransactionImport();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransImportTabBloc, TransImportTabState>(builder: (context, state) {
      if (state is TransImportTabLoaded) {
        return buildPage(context, state);
      }
      return Scaffold(appBar: AppBar(title: const Text('导入账单')), body: buildShimmer());
    });
  }

  Widget buildPage(BuildContext context, TransImportTabLoaded state) {
    return DefaultTabController(
        length: state.list.length,
        child: Scaffold(
            appBar: AppBar(
                title: const Text('导入账单'),
                bottom: TabBar(
                  tabs: state.list.map((product) => Tab(text: product.name)).toList(),
                )),
            body: PageStorage(
                bucket: PageStorageBucket(),
                child: TabBarView(
                    children: List.generate(state.list.length, (index) {
                  return _buidlButtonGroup(context, state.list[index], state.tree);
                })))));
  }

  Widget _buidlButtonGroup(BuildContext context, ProductModel product,
      List<MapEntry<TransactionCategoryFatherModel, List<TransactionCategoryModel>>> categoryTree) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocProvider<PtcCardBloc>(
            create: (context) => PtcCardBloc(product)..add(FetchPtcList()),
            child: PtcCard(categoryTree),
          ),
          SizedBox(
            width: 250,
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(const StadiumBorder(side: BorderSide(style: BorderStyle.none)))),
              onPressed: () {
                _uploadBillFile(product, context);
              },
              child: Text(
                "导  入",
                style: TextStyle(
                  fontSize: Theme.of(context).primaryTextTheme.titleMedium!.fontSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _uploadBillFile(ProductModel product, BuildContext context) async {
    await FileOperation.selectFile(FileType.custom, ['xls', 'xlsx', 'csv']).then((value) {
      if (value != null) {
        BlocProvider.of<TransImportTabBloc>(context).add(TransactionImportUploadBillEvent(product, value.path));
      }
    });
  }
}
