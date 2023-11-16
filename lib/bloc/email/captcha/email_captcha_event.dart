part of 'email_captcha_bloc.dart';

sealed class EmailCaptchaEvent {}

class ClickSendButtonEvent extends EmailCaptchaEvent {}

class EmailCaptchaLoadEvent extends EmailCaptchaEvent {
  final String email, captcha, captchaId;
  final UserAction type;
  EmailCaptchaLoadEvent(this.email, this.captcha, this.captchaId, this.type);
}
