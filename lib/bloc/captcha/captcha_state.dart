part of 'captcha_bloc.dart';

sealed class CaptchaState {}

final class CaptchaInitial extends CaptchaState {}

class CaptchaLoading extends CaptchaState {}

class CaptchaLoaded extends CaptchaState {
  final String picBase64;
  CaptchaLoaded(this.picBase64);
}

class CaptchaUpdateCountdown extends CaptchaState {
  final int second;
  CaptchaUpdateCountdown(this.second);
}
