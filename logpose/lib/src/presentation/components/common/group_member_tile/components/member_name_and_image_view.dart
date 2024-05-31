import 'package:flutter/cupertino.dart';

import '../../../../../domain/entity/user_profile.dart';

import '../../../../../utils/responsive_util.dart';

import '../../custom_image/custom_cached_network_image.dart';

import 'components/member_name_view.dart';

class MemberNameAndImageView extends StatelessWidget {
  const MemberNameAndImageView({super.key, required this.memberProfile});

  final UserProfile memberProfile;

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
      userImageSize: deviceWidth * 0.06,
      userNameTextSize: deviceWidth * 0.03,
    );
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(
      userImageSize: deviceWidth * 0.05,
      userNameTextSize: deviceWidth * 0.025,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(
      userImageSize: deviceWidth * 0.04,
      userNameTextSize: deviceWidth * 0.02,
    );
  }

  Widget _buildLayout({
    required double userImageSize,
    required double userNameTextSize,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 0.5,
            spreadRadius: 0.1,
            offset: Offset(1, 1),
            color: CupertinoColors.systemGrey,
          ),
        ],
        borderRadius: BorderRadius.circular(80),
        color: const Color.fromARGB(255, 248, 233, 255),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 3),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 10),
              child: CustomCachedNetworkImage(
                imagePath: memberProfile.image,
                width: userImageSize,
                height: userImageSize,
              ),
            ),
            MemberNameView(
              name: memberProfile.name,
              userNameTextSize: userNameTextSize,
            ),
          ],
        ),
      ),
    );
  }
}
