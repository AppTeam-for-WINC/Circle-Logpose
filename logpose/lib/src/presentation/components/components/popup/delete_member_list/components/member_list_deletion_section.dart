import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../utils/responsive_util.dart';

import '../../../../../notifiers/admin_member_tile_notifier.dart';
import '../../../../../notifiers/group_member_list_setter_notifier.dart';
import '../../../../../notifiers/membership_member_tile_notifier.dart';

import '../../../../common/group_member_tile/group_member_tile.dart';

import 'components/member_list_delete_section_label.dart';

class MemberListDeletionSection extends ConsumerStatefulWidget {
  const MemberListDeletionSection({super.key, required this.groupId});

  final String groupId;

  @override
  ConsumerState<MemberListDeletionSection> createState() =>
      _MemberListDeletionSectionState();
}

class _MemberListDeletionSectionState
    extends ConsumerState<MemberListDeletionSection> {
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
    final adminMemberTile = ref.watch(adminMemberTileNotifierNotifierProvider);
    final membershipMemberTile =
        ref.watch(membershipMemberTileNotifierProvider(widget.groupId));

    return Column(
      children: [
        const MemberListDeleteSectionLabel(),
        SingleChildScrollView(
          child: SizedBox(
            height: sizedBoxHeight,
            child: GridView.count(
              mainAxisSpacing: mainAxisSpacing,
              childAspectRatio: childAspectRatio,
              crossAxisCount: 1,
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              children: [
                adminMemberTile,
                ...membershipMemberTile,
                ...ref.watch(groupMemberListSetterNotifierProvider).map(
                      (memberProfile) => GroupMemberTile(
                        memberProfile: memberProfile,
                        groupRoleType: GroupRoleType.membership,
                        groupId: widget.groupId,
                      ),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
