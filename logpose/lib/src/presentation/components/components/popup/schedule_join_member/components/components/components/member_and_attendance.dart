import 'package:flutter/material.dart';

import '../../../../../../../../../utils/responsive_util.dart';

import '../../../../../../../../domain/entity/user_profile.dart';

import '../../../../../../common/custom_image/custom_image.dart';
import '../../../../../../common/user_name.dart';

import 'components/member_join_time.dart';

class MemberAndAttendance extends StatelessWidget {
  const MemberAndAttendance({
    super.key,
    required this.scheduleId,
    required this.userProfile,
  });

  final String scheduleId;
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
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
      titleWidth: deviceWidth * 0.45,
      titleMarginTop: deviceHeight * 0.12,
      textSize: deviceWidth * 0.035,
      imageSize: deviceWidth * 0.06,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      titleWidth: deviceWidth * 0.5,
      titleMarginTop: deviceHeight * 0.1,
      textSize: deviceWidth * 0.025,
      imageSize: deviceWidth * 0.04,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      titleWidth: deviceWidth * 0.5,
      titleMarginTop: deviceHeight * 0.08,
      textSize: deviceWidth * 0.025,
      imageSize: deviceWidth * 0.04,
    );
  }

  Widget _buildLayout({
    required double titleWidth,
    required double titleMarginTop,
    required double textSize,
    required double imageSize,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 3),
      margin: const EdgeInsets.only(right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: CustomImage(
                  imagePath: userProfile.image,
                  width: imageSize,
                  height: imageSize,
                ),
              ),
              Username(name: userProfile.name, textSize: textSize),
            ],
          ),
          MemberJoinTime(
            scheduleId: scheduleId,
            accountId: userProfile.accountId,
          ),
        ],
      ),
    );
  }
}
