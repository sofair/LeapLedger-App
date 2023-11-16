import 'package:bloc/bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

enum TabPage { home, flow, share, userHome }

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(InHomePage()) {
    on<NavigateToHomePage>(_navigateToHomePage);
    on<NavigateToFlowPage>(_navigateToFlowPage);
    on<NavigateToSharePage>(_navigateToSharePage);
    on<NavigateToUserHomePage>(_navigateToUserHomePage);
  }
  TabPage currentDisplayPage = TabPage.home;
  _navigateToHomePage(NavigateToHomePage event, Emitter<NavigationState> emit) {
    currentDisplayPage = TabPage.home;
    emit(InHomePage());
  }

  _navigateToFlowPage(NavigateToFlowPage event, Emitter<NavigationState> emit) {
    currentDisplayPage = TabPage.flow;
    emit(InFlowPage());
  }

  _navigateToSharePage(NavigateToSharePage event, Emitter<NavigationState> emit) {
    currentDisplayPage = TabPage.share;
    emit(InSharePage());
  }

  _navigateToUserHomePage(NavigateToUserHomePage event, Emitter<NavigationState> emit) {
    emit(InUserHomePage());
  }
}
