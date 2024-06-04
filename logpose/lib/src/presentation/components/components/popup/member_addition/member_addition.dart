import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../utils/responsive_util.dart';

import 'components/invitation_link/copy_invitation_link_button.dart';
import 'components/search_field_section/user_search_field_section.dart';
import 'components/user_profile/user_profile_button.dart';

class MemberAddition extends ConsumerStatefulWidget {
  const MemberAddition({super.key, required this.groupId});

  final String? groupId;

  @override
  ConsumerState<MemberAddition> createState() => _MemberAdditionState();
}

class _MemberAdditionState extends ConsumerState<MemberAddition> {
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
      containerWidth: deviceWidth * 0.8,
      containerHeight: deviceHeight * 0.35,
      paddingTop: 20,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.8,
      containerHeight: deviceHeight * 0.35,
      paddingTop: 30,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.8,
      containerHeight: deviceHeight * 0.35,
      paddingTop: 40,
    );
  }

  Widget _buildLayout({
    required double containerWidth,
    required double containerHeight,
    required double paddingTop,
  }) {
    final groupId = widget.groupId;

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: Container(
          width: containerWidth,
          height: containerHeight,
          color: const Color(0xFFF5F3FE),
          padding: EdgeInsets.only(top: paddingTop),
          child: Column(
            children: [
              UserSearchFieldSection(groupId: groupId),
              const Spacer(),
              UserProfileButton(groupId: groupId),
              const Spacer(),
              if (groupId != null) CopyInvitationLinkButton(groupId: groupId),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
