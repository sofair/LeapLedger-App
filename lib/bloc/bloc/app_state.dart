part of 'app_bloc.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AppLoadingState extends AppState {}

class AppLoadedState extends AppState {}

class AppErrorState extends AppState {
  final String msg;
  AppErrorState(this.msg);
}
