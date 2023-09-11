import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepaccount_app/api/api_server.dart';
import 'package:keepaccount_app/common/global.dart';
import 'package:keepaccount_app/config/user.dart';
import 'package:keepaccount_app/model/account/account.dart';
import 'package:keepaccount_app/routes/routes.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  bool isLogin = false;
  static User? user;
  static AccountModel currentAccount = AccountModel.fromJson({});
  static String username = '';
  static String token = '';

  UserBloc() : super(UserInitial()) {
    getToCache();
    on<SetCurrentAccountId>(_setCurrentAccountId);
    on<UserLoginEvent>(_login);
  }

  void _setCurrentAccountId(
      SetCurrentAccountId event, Emitter<UserState> emit) async {
    if (event.accountId == currentAccount.id) {
      emit(UpdateCurrentAccount());
    }
    var responseBody = await UserApi.setCurrentAccount(event.accountId);
    if (responseBody.isSuccess) {
      UserBloc.currentAccount.id = event.accountId;
      UserBloc.saveToCache();
      emit(UpdateCurrentAccount());
    }
  }

  void _login(UserLoginEvent event, Emitter<UserState> emit) async {
    var bytes = utf8.encode(event.userAccount + event.password);
    var password = sha256.convert(bytes).toString();
    var response = await UserApi.login(event.userAccount, password);
    if (response.isSuccess) {
      username = event.userAccount;
      currentAccount = AccountModel.fromJson(response.data['CurrentAccount']);
      token = response.data['Token'];
      UserBloc.saveToCache();
      emit(UserLoginedState());
      emit(UpdateCurrentAccount());
    } else {
      emit(UserLoginFailState(response.msg));
    }
  }

  // Remaining methods unchanged

  static saveToCache() => Global.cache.save('User', {
        'Username': username,
        'Token': token,
        'CurrentAccount': currentAccount.toJson(),
      });

  static getToCache() {
    Map<String, dynamic> prefsData = Global.cache.getData('User');
    username = prefsData['Username'] ?? '';
    token = prefsData['Token'] ?? '';
    currentAccount = AccountModel.fromJson(prefsData['CurrentAccount'] ?? {});
  }

  static Widget listenerCurrentAccountIdUpdate(Function func, Widget widget) {
    return BlocListener<UserBloc, UserState>(
        listener: (_, state) {
          if (state is UpdateCurrentAccount) {
            func();
          }
        },
        child: widget);
  }

  static checkUserState(BuildContext context) {
    if (token == '') {
      Future.delayed(Duration.zero, () {
        Navigator.pushNamed(context, Routes.login);
      });
    }
  }
}
