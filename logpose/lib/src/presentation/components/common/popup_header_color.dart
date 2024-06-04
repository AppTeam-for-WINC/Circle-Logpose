import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/color_exchanger.dart';
import '../../../utils/responsive_util.dart';

class PopupHeaderColor extends ConsumerWidget {
  const PopupHeaderColor({super.key, required this.color});

  final String color;

  Color _hexToColor(String color) {
    return hexToColor(color);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtil.isMobile(context)) {
          return _buildMobileLayout(deviceHeight);
        } else if (ResponsiveUtil.isTablet(context)) {
          return _buildTabletLayout(deviceHeight);
        } else {
          return _buildDesktopLayout(deviceHeight);
        }
      },
    );
  }

  Widget _buildMobileLayout(double deviceHeight) {
    return _buildLayout(deviceHeight * 0.09);
  }

  Widget _buildTabletLayout(double deviceHeight) {
    return _buildLayout(deviceHeight * 0.08);
  }

  Widget _buildDesktopLayout(double deviceHeight) {
    return _buildLayout(deviceHeight * 0.07);
  }

  Widget _buildLayout(double scheduleColorHeaderHeight) {
    return Container(
      height: scheduleColorHeaderHeight,
      color: _hexToColor(color),
    );
  }
}
