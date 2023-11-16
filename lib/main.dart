import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:keepaccount_app/bloc/user/user_bloc.dart';
import 'package:keepaccount_app/routes/routes.dart';
import 'package:keepaccount_app/util/enter.dart';
import 'package:keepaccount_app/view/navigation/navigation.dart';

import 'common/global.dart';
import 'package:keepaccount_app/common/current.dart';

Future<void> main() async {
  init().then((e) => runApp(const MyApp()));
}

Future<void> init() async {
  const String envName = String.fromEnvironment("ENV");
  Current.env = ENV.values.firstWhere((e) => e.toString().split('.').last == envName);
  await initCache();
  Routes.init();
  await Global.init();
  Global.cache.clear();
  await Current.init();
}

initCache() async {
  await SharedPreferencesCache.init();
  UserBloc.getToCache();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserBloc>(
            create: (context) => UserBloc(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: Global.navigatorKey,
          title: 'Flutter Demo',
          theme: ThemeData(
            dividerColor: Colors.transparent,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.blue,
              shape: CircleBorder(),
              // smallSizeConstraints: BoxConstraints(minWidth: 100),
              // extendedSizeConstraints: BoxConstraints(minWidth: 100),
            ),
            //useMaterial3: true,
          ),
          home: Navigation(),
          builder: EasyLoading.init(),
          routes: Routes.routes,
          onGenerateRoute: Routes.generateRoute,
        ));
  }
}
