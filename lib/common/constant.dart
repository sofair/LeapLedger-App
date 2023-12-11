part of 'global.dart';

class Constant {
  static const double radius = 12.0;
  static const double padding = 12.0;
  static const double margin = 8.0;
}

class ConstantWidget {
  // ignore: library_private_types_in_public_api
  static const _ConstantWidgetDivider divider = _ConstantWidgetDivider();
}

class ConstantDecoration {
  static const Radius radius = Radius.circular(Constant.radius);
  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(Constant.radius));
  //BoxDecoration
  static const BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: ConstantDecoration.borderRadius,
  );
  static const BoxDecoration bottomSheet = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: ConstantDecoration.radius,
      topRight: ConstantDecoration.radius,
    ),
  );
}

class _ConstantWidgetDivider {
  const _ConstantWidgetDivider();
  final Divider list = const Divider(
    color: Color.fromRGBO(238, 238, 238, 1),
    height: 0.5,
    thickness: 0.5,
  );
}

class ConstantColor {
  static const Color primaryColor = Colors.blue;
  static const Color incomeAmount = Colors.lightGreen;
  static const Color expenseAmount = Colors.red;
  static const Color shimmerBaseColor = Color.fromRGBO(224, 224, 224, 1);
  static const Color shimmerHighlightColor = Color.fromRGBO(245, 245, 245, 1);
}
