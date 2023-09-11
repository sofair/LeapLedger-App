import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepaccount_app/bloc/transaction/category/transaction_category_bloc.dart';
import 'package:keepaccount_app/model/transaction/category/model.dart';
import 'package:keepaccount_app/widget/form/form.dart';

class TransactionCategoryEdit extends StatelessWidget {
  final TransactionCategoryModel? transactionCategory;

  const TransactionCategoryEdit({super.key, this.transactionCategory});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionCategoryBloc>(
        create: (context) => TransactionCategoryBloc(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('编辑交易类型'),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _EditForm(transactionCategory ??
                    TransactionCategoryModel.fromJson({})))));
  }
}

class _EditForm extends StatefulWidget {
  final TransactionCategoryModel transactionCategory;

  const _EditForm(this.transactionCategory, {Key? key}) : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<_EditForm> {
  final _formKey = GlobalKey<FormState>();
  void pop(BuildContext context, TransactionCategoryModel transactionCategory) {
    Navigator.pop(context, transactionCategory);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionCategoryBloc, TransactionCategoryState>(
        listener: (context, state) {
          if (state is SaveSuccessState) {
            pop(context, state.transactionCategory);
          }
        },
        child: buildForm());
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                stringForm('名称', widget.transactionCategory.name,
                    (text) => widget.transactionCategory.name = text)
              ],
            ),
          ),
          saveButton(
              context,
              (context) => BlocProvider.of<TransactionCategoryBloc>(context)
                  .add(TransactionCategorySaveEvent(
                      widget.transactionCategory))),
        ],
      ),
    );
  }
}
