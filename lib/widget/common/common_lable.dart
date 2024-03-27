part of 'common.dart';

class CommonLabel extends StatelessWidget {
  const CommonLabel({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: ConstantDecoration.borderRadius,
        color: ConstantColor.secondaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: Constant.smallPadding),
        child: Text(
          text,
          style: const TextStyle(fontSize: ConstantFontSize.bodySmall, height: 1.7),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
