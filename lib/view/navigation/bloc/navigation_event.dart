part of 'navigation_bloc.dart';

abstract class NavigationEvent {}

class RefreshEvent {}

class ChangeTabPageEvent extends NavigationEvent {
  TabPage currentTab;
  ChangeTabPageEvent(this.currentTab);
}
