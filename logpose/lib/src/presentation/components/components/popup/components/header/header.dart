import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../utils/color/color_exchanger.dart';

class Header extends ConsumerWidget {
  const Header({super.key, required this.color});
  final String color;

  Color _hexToColor(String color) {
    return hexToColor(color);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      height: deviceHeight * 0.11,
      color: _hexToColor(color),
    );
  }
}
