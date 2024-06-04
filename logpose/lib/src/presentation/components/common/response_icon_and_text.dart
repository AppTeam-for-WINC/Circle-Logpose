import 'package:flutter/cupertino.dart';

import '../../../utils/responsive_util.dart';
import '../../../utils/schedule_response.dart';

class ResponseIconAndText extends StatelessWidget {
  const ResponseIconAndText({super.key, required this.responseType});

  final ResponseType? responseType;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    if (responseType == null) {
      return const SizedBox.shrink();
    }

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
      containerSize: deviceWidth * 0.2,
      iconSize: deviceWidth * 0.058,
      textSize: deviceWidth * 0.045,
      marginTop: deviceWidth * 0.22,
      marginLeft: deviceWidth * 0.63,
    );
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(
      containerSize: deviceWidth * 0.14,
      iconSize: deviceWidth * 0.04,
      textSize: deviceWidth * 0.03,
      marginTop: deviceWidth * 0.14,
      marginLeft: deviceWidth * 0.7,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(
      containerSize: deviceWidth * 0.1,
      iconSize: deviceWidth * 0.03,
      textSize: deviceWidth * 0.022,
      marginTop: deviceWidth * 0.1,
      marginLeft: deviceWidth * 0.75,
    );
  }

  Widget _buildLayout({
    required double containerSize,
    required double iconSize,
    required double textSize,
    required double marginTop,
    required double marginLeft,
  }) {
    final responseIcon = ScheduleResponse.getIcon(responseType!, iconSize);
    final responseText = ScheduleResponse.getText(responseType!, textSize);

    return Container(
      width: containerSize,
      height: containerSize,
      margin: EdgeInsets.only(top: marginTop, left: marginLeft),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: const Color(0xFFFBCEFF),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [responseIcon, responseText],
        ),
      ),
    );
  }
}
