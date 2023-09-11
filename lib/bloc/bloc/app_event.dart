part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}

class AppLoadingEvent extends AppEvent {}

class AppLoadFailEvent extends AppEvent {
  final String msg;
  AppLoadFailEvent(this.msg);
}

class AppLoadSuccessEvent extends AppEvent {}
