import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../domain/entity/user_profile.dart';

import '../../../../../../../utils/responsive_util.dart';

import '../../../../../../handlers/user_profile_button_handler.dart';

import '../../../../../../notifiers/search_user_notifier.dart';

import '../../../../../common/custom_image/custom_image.dart';
import '../../../../../common/user_name.dart';

class UserProfileButton extends ConsumerStatefulWidget {
  const UserProfileButton({super.key, required this.groupId});

  final String? groupId;

  @override
  ConsumerState<UserProfileButton> createState() => _UserProfileButtonState();
}

class _UserProfileButtonState extends ConsumerState<UserProfileButton> {
  void handlAddMember(UserProfile userProfile) {
    UserProfileButtonHandler(
      ref: ref,
      groupId: widget.groupId,
      userProfile: userProfile,
    ).handleToAddMember();
  }

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
      containerWidth: deviceWidth * 0.5,
      containerHeight: deviceHeight * 0.08,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.4,
      containerHeight: deviceHeight * 0.06,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.4,
      containerHeight: deviceHeight * 0.04,
    );
  }

  Widget _buildLayout({
    required double containerWidth,
    required double containerHeight,
  }) {
    final groupId = widget.groupId;
    final userProfile = ref.watch(searchUserNotifierProvider(groupId));
    if (userProfile == null) {
      return const SizedBox.shrink();
    }

    return ColoredBox(
      color: const Color(0xFFF5F3FE),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F0FF),
          borderRadius: BorderRadius.circular(80),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFD9D9D9),
              offset: Offset(0, 2),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => handlAddMember(userProfile),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImage(imagePath: userProfile.image, width: 40, height: 40),
              Username(name: userProfile.name, textSize: 18),
            ],
          ),
        ),
      ),
    );
  }
}
