import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../utils/responsive_util.dart';
import '../../../../common/schedule_view_label.dart';

class ScheduleDetailView extends ConsumerWidget {
  const ScheduleDetailView({super.key, required this.detail});
  final String? detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtil.isMobile(context)) {
          return _buildMobileLayout(deviceWidth, deviceHeight);
        } else if (ResponsiveUtil.isTablet(context)) {
          return _buildTabletLayout(deviceWidth, deviceHeight);
        } else {
          return _buildDesktopLayout(deviceWidth, deviceHeight);
        }
      },
    );
  }

  Widget _buildMobileLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      iconSize: deviceWidth * 0.032,
      textSize: deviceWidth * 0.03,
      marginTop: deviceHeight * 0.04,
      maxHeight: deviceHeight * 0.08,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      iconSize: deviceWidth * 0.022,
      textSize: deviceWidth * 0.02,
      marginTop: deviceHeight * 0.04,
      maxHeight: deviceHeight * 0.08,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      iconSize: deviceWidth * 0.018,
      textSize: deviceWidth * 0.015,
      marginTop: deviceHeight * 0.04,
      maxHeight: deviceHeight * 0.08,
    );
  }

  Widget _buildLayout({
    required double iconSize,
    required double textSize,
    required double marginTop,
    required double maxHeight,
  }) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScheduleViewLabel(
            icon: CupertinoIcons.text_justify,
            label: '詳細',
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(right: 30),
                child: detail != null
                    ? Text(
                        detail!,
                        style: const TextStyle(fontSize: 18),
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
