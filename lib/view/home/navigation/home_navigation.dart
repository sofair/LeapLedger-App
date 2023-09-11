import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepaccount_app/bloc/user/user_bloc.dart';
import 'package:keepaccount_app/model/account/account.dart';
import 'package:keepaccount_app/routes/routes.dart';

import 'bloc/home_navigation_bloc.dart';

class HomeNavigation extends StatelessWidget {
  const HomeNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeNavigationBloc>(
      create: (_) => HomeNavigationBloc()..add(HomeNavigationinitEvent()),
      child: const SizedBox(height: 100.0, child: Navigation()),
    );
  }
}

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  NavigationState createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  AccountModel account = UserBloc.currentAccount;
  @override
  Widget build(BuildContext context) {
    return UserBloc.listenerCurrentAccountIdUpdate(() {
      setState(() {
        account = UserBloc.currentAccount;
      });
    },
        navigatorButtons([
          navigatorButton(
              title: "当前账单",
              subTitle: account.name,
              color: Colors.blue,
              route: AccountRoutes.list),
          navigatorButton(
              title: "设置交易类型",
              color: Colors.blue,
              icon: Icons.abc,
              route: TransactionCategoryRoutes.setting),
          navigatorButton(
              title: "导入账单",
              color: Colors.blue,
              route: TransactionImportRoutes.home),
          navigatorButton(
              title: "导出账单", color: Colors.blue, route: AccountRoutes.list)
        ]));
  }

  Widget navigatorButtons(List<Widget> list) {
    return ListView(
      padding: const EdgeInsets.all(5),
      scrollDirection: Axis.horizontal,
      children: list,
    );
  }

  Widget navigatorButton(
      {required String title,
      String? subTitle,
      required Color color,
      IconData? icon,
      required String route}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        width: 150,
        height: 70,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16)),
                  if (subTitle != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(width: icon != null ? 20 : 46),
                        Text(
                          subTitle,
                          style: const TextStyle(fontSize: 14),
                        )
                      ],
                    )
                  ]
                ],
              ),
              if (icon != null)
                Icon(
                  icon,
                  color: Colors.white,
                  size: 36,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
