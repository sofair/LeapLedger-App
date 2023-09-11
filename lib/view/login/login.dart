import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keepaccount_app/bloc/user/user_bloc.dart';

import 'package:keepaccount_app/widget/toast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  loginState createState() => loginState();
}

class loginState extends State<Login> {
  late TextEditingController accountController;
  late TextEditingController pwdController;
  bool? checked = false;

  @override
  void initState() {
    super.initState();

    accountController = TextEditingController(text: UserBloc.username);
    pwdController = TextEditingController();
  }

  @override
  void dispose() {
    accountController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    String account = accountController.value.text;
    String pwd = pwdController.value.text;
    if (account.isEmpty) {
      Fluttertoast.showToast(msg: '请输入手机号');
      return;
    }
    if (pwd.isEmpty) {
      Fluttertoast.showToast(msg: '请输入密码');
      return;
    }
    if (!checked!) {
      Fluttertoast.showToast(msg: '请同意用户协议和隐私政策');
      return;
    }
    //_skipToMain();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoginFailState) {
            tipToast(state.msg);
          } else if (state is UserLoginedState) {
            tipToast("登录成功");
            Navigator.pop(context, true);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "登录",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: '账号',
                ),
                controller: accountController,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: '密码',
                ),
                controller: pwdController,
                obscureText: true, // 将文本内容隐藏为圆点以显示密码字段
              ),
              const SizedBox(height: 70),
              buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoginButton() {
    return Align(
      child: SizedBox(
        height: 45,
        width: 270,
        child: ElevatedButton(
          style: ButtonStyle(
              // 设置圆角
              shape: MaterialStateProperty.all(const StadiumBorder(
                  side: BorderSide(style: BorderStyle.none)))),
          child: Text('登录',
              style: Theme.of(context).primaryTextTheme.headlineSmall),
          onPressed: () {
            RepositoryProvider.of<UserBloc>(context).add(UserLoginEvent(
                accountController.value.text, pwdController.value.text));
          },
        ),
      ),
    );
  }
}

//用户协议和隐私政策
class PrivacyWidget extends StatefulWidget {
  const PrivacyWidget({Key? key, required this.onChanged}) : super(key: key);
  final ValueChanged<bool?> onChanged;

  @override
  _PrivacyWidgetState createState() => _PrivacyWidgetState();
}

class _PrivacyWidgetState extends State<PrivacyWidget> {
  bool? checked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: checked,
            onChanged: (value) {
              widget.onChanged(value);
              setState(() {
                checked = value;
              });
            }),
        const Text(
          '同意',
          style: TextStyle(fontSize: 14),
        ),
        const Text(
          '<服务协议>',
          style: TextStyle(fontSize: 14, color: Colors.blue),
        ),
        const Text(
          '和',
          style: TextStyle(fontSize: 14),
        ),
        const Text('<隐私政策>',
            style: TextStyle(fontSize: 14, color: Colors.blue)),
      ],
    );
  }
}
