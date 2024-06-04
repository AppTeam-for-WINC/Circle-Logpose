import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/responsive_util.dart';

class CustomScheduleTextField extends ConsumerWidget {
  const CustomScheduleTextField({
    super.key,
    required this.textController,
    required this.placeholder,
  });

  final TextEditingController textController;
  final String placeholder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtil.isMobile(context)) {
          return _buildMobileLayout(deviceWidth);
        } else if (ResponsiveUtil.isTablet(context)) {
          return _buildTabletLayout(deviceWidth);
        } else {
          return _buildDesktopLayout(deviceWidth);
        }
      },
    );
  }

  Widget _buildMobileLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.04);
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.025);
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.018);
  }

  Widget _buildLayout(double textSize) {
    return CupertinoTextField(
      controller: textController,
      placeholder: placeholder,
      placeholderStyle: const TextStyle(color: CupertinoColors.systemGrey),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(style: BorderStyle.none)),
      ),
      style: TextStyle(fontSize: textSize, color: CupertinoColors.black),
    );
  }
}
