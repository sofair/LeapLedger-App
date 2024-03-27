part of 'navigation_bloc.dart';

abstract class NavigationEvent {}

class ChangeAccountEvent extends NavigationEvent {
  final AccountDetailModel account;
  ChangeAccountEvent(this.account);
}

class NavigateToHomePage extends NavigationEvent {
  NavigateToHomePage();
}

class NavigateToFlowPage extends NavigationEvent {
  NavigateToFlowPage();
}

class NavigateToSharePage extends NavigationEvent {
  NavigateToSharePage();
}

class NavigateToUserHomePage extends NavigationEvent {
  NavigateToUserHomePage();
}
