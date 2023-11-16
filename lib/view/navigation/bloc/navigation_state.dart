part of 'navigation_bloc.dart';

abstract class NavigationState {}

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
