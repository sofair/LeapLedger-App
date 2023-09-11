import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepaccount_app/bloc/transaction/category/father/trans_cat_father_bloc.dart';
import 'package:keepaccount_app/model/transaction/category/model.dart';
import 'package:keepaccount_app/widget/form/form.dart';

class TransactionCategoryFatherEdit extends StatelessWidget {
  final TransactionCategoryFatherModel? modle;
  const TransactionCategoryFatherEdit(this.modle, {super.key});

  @override
  Widget build(BuildContext context) {
    print(modle);
    return BlocProvider<TransCatFatherBloc>(
        create: (context) => TransCatFatherBloc(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('编辑交易类型'),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _EditForm(modle ?? TransactionCategoryFatherModel.fromJson({})))));
  }
}

class _EditForm extends StatefulWidget {
  final TransactionCategoryFatherModel transactionCategoryFather;

  const _EditForm(this.transactionCategoryFather, {Key? key}) : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<_EditForm> {
  final _formKey = GlobalKey<FormState>();
  void pop(BuildContext context, TransactionCategoryFatherModel transactionCategory) {
    Navigator.pop(context, transactionCategory);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransCatFatherBloc, TransCatFatherState>(
        listener: (context, state) {
          if (state is SaveSuccessState) {
            pop(context, state.transactionCategoryFather);
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
                stringForm(
                    '名称', widget.transactionCategoryFather.name, (text) => widget.transactionCategoryFather.name = text)
              ],
            ),
          ),
          saveButton(
              context,
              (context) => BlocProvider.of<TransCatFatherBloc>(context)
                  .add(TransCatFatherSaveEvent(widget.transactionCategoryFather))),
        ],
      ),
    );
  }
}
