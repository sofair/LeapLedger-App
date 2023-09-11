import 'package:bloc/bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

enum TabPage { home, transaction, group, mine }

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(HomeInitial()) {
    on<ChangeTabPageEvent>(_changeTabPage);
  }

  _changeTabPage(ChangeTabPageEvent event, Emitter<NavigationState> emit) {
    emit(InTabPageState(currentTabPage: event.currentTab));
  }
}
