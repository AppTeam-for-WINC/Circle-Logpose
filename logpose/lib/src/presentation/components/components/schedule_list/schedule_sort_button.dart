import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/responsive_util.dart';
import '../../../handlers/schedule_sort_button_hanlder.dart';

class ScheduleSortButton extends ConsumerStatefulWidget {
  const ScheduleSortButton({super.key, required this.deviceWidth});

  final double deviceWidth;

  @override
  ConsumerState<ScheduleSortButton> createState() {
    return _ScheduleSortButtonState();
  }
}

class _ScheduleSortButtonState extends ConsumerState<ScheduleSortButton> {
  void _handleSort() {
    ScheduleSortButtonHandler(context, ref).handleToSort();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = widget.deviceWidth;
    return CupertinoButton(
      onPressed: _handleSort,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (ResponsiveUtil.isMobile(context)) {
            return _buildMobileLayout(deviceWidth);
          } else if (ResponsiveUtil.isTablet(context)) {
            return _buildTabletLayout(deviceWidth);
          } else {
            return _buildDesktopLayout(deviceWidth);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(double deviceWidth) {
    return _buildLayout(
      fontSize: deviceWidth * 0.035,
      iconSize: deviceWidth * 0.04,
    );
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(
      fontSize: deviceWidth * 0.03,
      iconSize: deviceWidth * 0.05,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(
      fontSize: deviceWidth * 0.025,
      iconSize: deviceWidth * 0.045,
    );
  }

  Widget _buildLayout({
    required double fontSize,
    required double iconSize,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '並び替え',
          style: TextStyle(
            color: const Color(0xFF7B61FF),
            fontSize: fontSize,
          ),
        ),
        Icon(
          CupertinoIcons.sort_down,
          color: const Color(0xFF7B61FF),
          size: iconSize,
        ),
      ],
    );
  }
}
