part of 'navigation_bloc.dart';

abstract class NavigationState {}

class HomeInitial extends NavigationState {}

class LoadingState extends NavigationState {}

class LoadedState extends NavigationState {}

class InTabPageState extends NavigationState {
  late TabPage currentTabPage;
  InTabPageState({this.currentTabPage = TabPage.home});
}
