part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UpdateCurrentAccount extends UserState {}

class UserLoginedState extends UserState {}

class UserLoginFailState extends UserState {
  final String msg;
  UserLoginFailState(this.msg);
}
