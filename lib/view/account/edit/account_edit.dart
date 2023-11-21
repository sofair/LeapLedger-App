import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepaccount_app/model/account/model.dart';
import 'package:keepaccount_app/view/account/bloc/account_bloc.dart';
import 'package:keepaccount_app/widget/form/form.dart';

class AccountEdit extends StatelessWidget {
  const AccountEdit({super.key});
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final AccountModel accountModel = args?['accountModel'] ?? AccountModel.fromJson({});
    return BlocProvider<AccountBloc>(create: (context) => AccountBloc(), child: EditForm(accountModel));
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
        child: Scaffold(
            appBar: AppBar(
              title: const Text('编辑账本'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.save,
                    size: 24,
                  ),
                  onPressed: () => BlocProvider.of<AccountBloc>(context).add(AccountSaveEvent(widget._accountMode)),
                ),
              ],
            ),
            body: buildForm()));
  }

  Widget buildForm() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(90),
                ),
                margin: const EdgeInsets.only(bottom: 16),
                width: 64,
                height: 64,
                child: Icon(
                  widget._accountMode.icon,
                  size: 32,
                  color: Colors.black87,
                ),
              ),
              FormInputField.string('名称', widget._accountMode.name, (text) => widget._accountMode.name = text),
              const SizedBox(
                height: 16,
              ),
              FormSelecter.accountIcon(widget._accountMode.icon, onChanged: _onSelectIcon),
            ],
          ),
        ));
  }

  void _onSelectIcon(IconData selectValue) {
    setState(() {
      widget._accountMode.icon = selectValue;
    });
  }
}

class TestAccountEdit extends StatelessWidget {
  const TestAccountEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return const AccountEdit();
  }
}
