part of 'enter.dart';

class AmountInput extends StatelessWidget {
  static InputDecoration defaultDecoration = InputDecoration(
    contentPadding: EdgeInsets.all(Constant.padding),
    prefixText: "￥",
    labelStyle: TextStyle(fontSize: ConstantFontSize.body),
    border: OutlineInputBorder(),
    // You can further style the input here
  );
  final Function(int?)? onSave;
  final Function(int?)? onChanged;
  late final InputDecoration decoration;
  final int? initialValue;
  final TextEditingController? controller;
  AmountInput({
    super.key,
    this.onSave,
    this.onChanged,
    this.initialValue,
    InputDecoration? decoration,
    this.controller,
  }) {
    this.decoration = decoration ?? defaultDecoration;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 132.sp,
      height: 48,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: ConstantFontSize.body),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        initialValue: initialValue != null ? (initialValue! / 100).toStringAsFixed(2) : null,
        showCursor: true,
        maxLength: 10,
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
        buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
        decoration: decoration,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        onSaved: (String? value) => onSave != null ? onSave!(stringToAmount(value)) : null,
        onChanged: (String? value) => onChanged != null ? onChanged!(stringToAmount(value)) : null,
      ),
    );
  }

  int? stringToAmount(String? value) {
    double? doubleResult = Data.stringToDouble(value);
    return doubleResult != null ? (doubleResult * 100).toInt() : null;
  }
}
