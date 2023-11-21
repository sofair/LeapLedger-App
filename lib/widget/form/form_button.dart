part of 'form.dart';

class FormButton {
  static Widget save(BuildContext context, Function(BuildContext context) submitForm) {
    return ElevatedButton(
      onPressed: () => submitForm(context),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      ),
      child: const Text(
        '保 存',
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }

  static Widget elevatedSaveBtn(BuildContext context, Function(BuildContext context) submitForm) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => submitForm(context),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: const Text(
          '保 存',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
