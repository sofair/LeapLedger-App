part of 'email_captcha_bloc.dart';

sealed class EmailCaptchaState {}

final class EmailCaptchaInitial extends EmailCaptchaState {}

class EmailCaptchaLoading extends EmailCaptchaState {}

class EmailCaptchaLoaded extends EmailCaptchaState {
  final int countdown;
  EmailCaptchaLoaded(this.countdown);
}
