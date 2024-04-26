import 'package:flutter/cupertino.dart';
import '../../../../utils/color/color_exchanger.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.colorToString});
  final String colorToString;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: hexToColor(colorToString),
      ),
    );
  }
}
