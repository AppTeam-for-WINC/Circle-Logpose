import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../utils/responsive_util.dart';

import '../../../../providers/text_field/schedule_title_controller_provider.dart';

class TitleTextField extends ConsumerStatefulWidget {
  const TitleTextField({super.key});

  @override
  ConsumerState<TitleTextField> createState() => _TitleTextFieldState();
}

class _TitleTextFieldState extends ConsumerState<TitleTextField> {
  @override
  Widget build(BuildContext context) {
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
    return _buildLayout(
      sizedBoxWidth: deviceWidth * 0.7,
      titleTextSize: deviceWidth * 0.038,
    );
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(
      sizedBoxWidth: deviceWidth * 0.7,
      titleTextSize: deviceWidth * 0.025,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(
      sizedBoxWidth: deviceWidth * 0.7,
      titleTextSize: deviceWidth * 0.018,
    );
  }

  Widget _buildLayout({
    required double sizedBoxWidth,
    required double titleTextSize,
  }) {
    return Center(
      child: SizedBox(
        width: sizedBoxWidth,
        child: CupertinoTextField(
          controller: ref.watch(scheduleTitleControllerProvider.notifier).state,
          placeholder: 'タイトルを追加',
          placeholderStyle: const TextStyle(color: CupertinoColors.systemGrey),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
          style: TextStyle(
            fontSize: titleTextSize,
            color: CupertinoColors.black,
          ),
        ),
      ),
    );
  }
}
