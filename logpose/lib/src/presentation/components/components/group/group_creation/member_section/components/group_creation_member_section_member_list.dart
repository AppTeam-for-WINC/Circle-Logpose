import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../utils/responsive_util.dart';

import '../../../../../../notifiers/group_member_list_setter_notifier.dart';
import '../../../../../../notifiers/member_section_admin_members_notiifer.dart';

import '../../../../../common/group_member_tile/group_member_tile.dart';

class GroupCreationMemberSectionMemberList extends ConsumerStatefulWidget {
  const GroupCreationMemberSectionMemberList({super.key});

  @override
  ConsumerState createState() => _GroupCreationMemberSectionMemberListState();
}

class _GroupCreationMemberSectionMemberListState
    extends ConsumerState<GroupCreationMemberSectionMemberList> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtil.isMobile(context)) {
          return _buildMobileLayout(deviceHeight);
        } else if (ResponsiveUtil.isTablet(context)) {
          return _buildTabletLayout(deviceHeight);
        } else {
          return _buildDesktopLayout(deviceHeight);
        }
      },
    );
  }

  Widget _buildMobileLayout(double deviceHeight) {
    return _buildLayout(
      sizedBoxHeight: deviceHeight * 0.34,
      mainAxisSpacing: 8,
      childAspectRatio: 6.5,
    );
  }

  Widget _buildTabletLayout(double deviceHeight) {
    return _buildLayout(
      sizedBoxHeight: deviceHeight * 0.34,
      mainAxisSpacing: 8,
      childAspectRatio: 12,
    );
  }

  Widget _buildDesktopLayout(double deviceHeight) {
    return _buildLayout(
      sizedBoxHeight: deviceHeight * 0.34,
      mainAxisSpacing: 8,
      childAspectRatio: 12,
    );
  }

  Widget _buildLayout({
    required double sizedBoxHeight,
    required double mainAxisSpacing,
    required double childAspectRatio,
  }) {
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          height: sizedBoxHeight,
          child: GridView.count(
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio: childAspectRatio,
            crossAxisCount: 1,
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: <Widget>[
              ...ref.watch(memberSectionAdminMembersNotifierProvider),
              ...ref.watch(groupMemberListSetterNotifierProvider).map(
                    (membershipUserProfile) => GroupMemberTile(
                      memberProfile: membershipUserProfile,
                      groupRoleType: GroupRoleType.membership,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
