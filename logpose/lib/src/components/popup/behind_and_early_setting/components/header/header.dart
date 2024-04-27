import 'package:flutter/cupertino.dart';
import '../../../../../utils/color/color_exchanger.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.colorToString});
  final String colorToString;

  Color _hexToColor(String color) {
    return hexToColor(color);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: _hexToColor(colorToString),
      ),
    );
  }
}
