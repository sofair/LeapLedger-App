import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:keepaccount_app/model/account/account.dart';

part 'home_navigation_event.dart';
part 'home_navigation_state.dart';

class HomeNavigationBloc
    extends Bloc<HomeNavigationEvent, HomeNavigationState> {
  HomeNavigationBloc() : super(HomeNavigationInitState());
  AccountModel account = AccountModel.fromJson({});
  @override
  Stream<HomeNavigationState> mapEventToState(
      HomeNavigationEvent event) async* {
    print(event);
    switch (event.runtimeType) {
      case HomeNavigationinitEvent:
        yield* init();
    }
  }

  Stream<HomeNavigationState> init() async* {
    print("ok");
    account = await AccountModel.getCurrent();
    yield HomeNavigationLoadedState();
  }
}
