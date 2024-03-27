import 'package:bloc/bloc.dart';
import 'package:keepaccount_app/model/account/model.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

enum TabPage { home, flow, share, userHome }

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc(this.account) : super(InHomePage()) {
    on<NavigateToHomePage>(_navigateToHomePage);
    on<NavigateToFlowPage>(_navigateToFlowPage);
    on<NavigateToSharePage>(_navigateToSharePage);
    on<NavigateToUserHomePage>(_navigateToUserHomePage);
    on<ChangeAccountEvent>(_changeAccount);
  }
  late AccountDetailModel account;
  TabPage currentDisplayPage = TabPage.home;
  _changeAccount(ChangeAccountEvent event, Emitter<NavigationState> emit) {
    account = event.account;
    emit(NavigationAccountChannged());
  }

  _navigateToHomePage(NavigateToHomePage event, Emitter<NavigationState> emit) {
    currentDisplayPage = TabPage.home;
    emit(InHomePage());
  }

  _navigateToFlowPage(NavigateToFlowPage event, Emitter<NavigationState> emit) {
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
