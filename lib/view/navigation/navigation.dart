import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepaccount_app/bloc/user/user_bloc.dart';
import 'package:keepaccount_app/view/home/home.dart';

import 'bloc/navigation_bloc.dart';
import 'package:keepaccount_app/view/transaction/flow/transaction_flow.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  void initState() {
    UserBloc.checkUserState(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<TabPage, Widget> pageMap = {
      TabPage.home: const Home(),
      TabPage.transaction: TransactionFlow(),
      TabPage.group: const Center(
        child: Text("group"),
      ),
      TabPage.mine: const Center(child: Text("mine"))
    };
    return BlocProvider(
        create: (BuildContext context) => NavigationBloc(),
        child: Scaffold(
            body: BlocSelector<NavigationBloc, NavigationState, InTabPageState>(
              selector: (state) {
                if (state is InTabPageState) {
                  return state;
                } else {
                  return InTabPageState(currentTabPage: TabPage.home);
                }
              },
              builder: (context, state) {
                return pageMap[state.currentTabPage]!;
              },
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {}, child: const Icon(Icons.add)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: const _DemoBottomAppBar(
              fabLocation: FloatingActionButtonLocation.centerDocked,
              shape: CircularNotchedRectangle(),
            )));
  }
}

class _DemoBottomAppBar extends StatelessWidget {
  const _DemoBottomAppBar({
    this.fabLocation = FloatingActionButtonLocation.endDocked,
    this.shape = const CircularNotchedRectangle(),
  });

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;

  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: shape,
      color: Colors.blue,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: <Widget>[
            _textIcon('首页', Icons.home_filled, TabPage.home, context),
            _textIcon('流水', Icons.compare_arrows, TabPage.transaction, context),
            if (centerLocations.contains(fabLocation)) const Spacer(),
            _textIcon('成员', Icons.people, TabPage.group, context),
            _textIcon('我的', Icons.person, TabPage.mine, context),
          ],
        ),
      ),
    );
  }

  Widget _textIcon(
      String label, IconData icon, TabPage tabPage, BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        BlocProvider.of<NavigationBloc>(context)
            .add(ChangeTabPageEvent(tabPage));
      },
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            )
          ]),
    ));
  }
}
