part of 'navigation_bloc.dart';

abstract class NavigationState {}

class NavigationAccountChannged extends NavigationState {
  NavigationAccountChannged();
}

class InHomePage extends NavigationState {
  InHomePage();
}

class InFlowPage extends NavigationState {
  InFlowPage();
}

class InSharePage extends NavigationState {
  InSharePage();
}

class InUserHomePage extends NavigationState {
  InUserHomePage();
}
