import 'package:flutter/material.dart';

class AmountDisplay extends StatelessWidget {
  final int amount;
  final Color? color;
  final FontWeight fontWeight;
  final TextStyle textStyle;
  final bool dollarSign, tailReduction;

  const AmountDisplay(
      {Key? key,
      required this.amount,
      this.color = Colors.black,
      this.fontWeight = FontWeight.bold,
      this.textStyle = const TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      this.dollarSign = false,
      this.tailReduction = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double amountInDollars = amount / 100.0;
    String formattedAmount = amountInDollars.toStringAsFixed(2);
    List<String> parts = formattedAmount.split('.');
    double? tailFontSize =
        tailReduction ? textStyle.fontSize! * 2 / 3 : textStyle.fontSize;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          dollarSign ? '￥${parts[0]}' : parts[0],
          style: textStyle,
        ),
        Text(
          '.${parts[1]}',
          style: textStyle.copyWith(fontSize: tailFontSize),
        )
      ],
    );
  }
}
