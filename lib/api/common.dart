part of 'api_server.dart';

class CommonApi {
  static Future<CommonCaptchaModel> getCaptcha() async {
    ResponseBody response = await ApiServer.request(Method.get, '$pubilcBaseUrl/captcha');
    return CommonCaptchaModel.fromJson(response.data);
  }

  static Future<ResponseBody> sendEmailCaptcha(String email, String captcha, String captchaId, UserAction type) async {
    ResponseBody response = await ApiServer.request(Method.post, '$pubilcBaseUrl/captcha/email/send',
        data: {"Captcha": captcha, "CaptchaId": captchaId, "Email": email, "Type": type.name});
    if (response.isSuccess) {
      tipToast("邮件已发送请耐心等待");
    }
    return response;
  }
}
