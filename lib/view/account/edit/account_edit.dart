import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepaccount_app/model/account/account.dart';
import 'package:keepaccount_app/view/account/bloc/account_bloc.dart';
import 'package:keepaccount_app/widget/form/form.dart';

class AccountEdit extends StatelessWidget {
  const AccountEdit({super.key});
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final AccountModel accountModel =
        args?['accountModel'] ?? AccountModel.fromJson({});
    return BlocProvider<AccountBloc>(
        create: (context) => AccountBloc(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('编辑账户'),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: EditForm(accountModel))));
  }
}

class EditForm extends StatefulWidget {
  final AccountModel _accountMode;
  const EditForm(
    this._accountMode, {
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _formKey = GlobalKey<FormState>();
  void pop(BuildContext context, AccountModel? result) {
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountSaveSuccessState) {
            pop(context, widget._accountMode);
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
                stringForm('账户名称', widget._accountMode.name,
                    (text) => widget._accountMode.name = text)
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<AccountBloc>(context)
                    .add(AccountSaveEvent(widget._accountMode));
              }
            },
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            ),
            child: const Text(
              '保 存',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
