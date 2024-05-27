import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/responsive_util.dart';
import '../../../utils/schedule_response.dart';

class ResponseButton extends ConsumerWidget {
  const ResponseButton({
    super.key,
    required this.isResponse,
    required this.responseType,
    required this.groupScheduleId,
    required this.handleResponse,
  });

  final bool isResponse;
  final ResponseType responseType;
  final String groupScheduleId;
  final Future<void> Function() handleResponse;

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
    return _buildLayout(
      containerWidth: deviceWidth * 0.185,
      containerHeight: deviceWidth * 0.185,
      iconSize: 25,
      textSize: 18,
    );
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.12,
      containerHeight: deviceWidth * 0.12,
      iconSize: deviceWidth * 0.038,
      textSize: deviceWidth * 0.025,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.1,
      containerHeight: deviceWidth * 0.1,
      iconSize: deviceWidth * 0.036,
      textSize: deviceWidth * 0.023,
    );
  }

  Widget _buildLayout({
    required double containerWidth,
    required double containerHeight,
    required double iconSize,
    required double textSize,
  }) {
    return GestureDetector(
      onTap: handleResponse,
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: isResponse ? const Color(0xFFFBCEFF) : CupertinoColors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScheduleResponse.getIcon(responseType, iconSize),
              ScheduleResponse.getText(responseType, textSize),
            ],
          ),
        ),
      ),
    );
  }
}
