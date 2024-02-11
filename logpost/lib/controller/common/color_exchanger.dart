
import 'package:flutter/cupertino.dart';

/// Exchange color to hexadecimal.
String colorToHex(Color color) {
  return '#${color.value.toRadixString(16).padLeft(8, '0')}';
}

/// Exchange hexadecimal to color
Color hexToColor(String hexColorString) {
  return Color(int.parse(hexColorString.replaceFirst('#', '0xff')));
}
