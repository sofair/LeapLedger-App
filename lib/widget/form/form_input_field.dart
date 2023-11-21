part of 'form.dart';

class FormInputField {
  static Widget string(String fieldName, String initialValue, void Function(String)? onChanged) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: fieldName,
        border: const OutlineInputBorder(),

        // You can further style the input here
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '请输入一个$fieldName';
        }
        return null;
      },
    );
  }
}
