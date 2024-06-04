import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entity/user_profile.dart';

import '../../../../utils/responsive_util.dart';

import '../../../providers/group/mode/group_member_delete_mode_provider.dart';

import 'components/member_deletion_button.dart';
import 'components/member_name_and_image_view.dart';

enum GroupRoleType { admin, membership }

class GroupMemberTile extends ConsumerStatefulWidget {
  const GroupMemberTile({
    super.key,
    required this.memberProfile,
    required this.groupRoleType,
    this.groupId,
  });

  final UserProfile memberProfile;
  final GroupRoleType groupRoleType;
  final String? groupId;

  @override
  ConsumerState<GroupMemberTile> createState() => _GroupMemberTileState();
}

class _GroupMemberTileState extends ConsumerState<GroupMemberTile> {
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
    return _buildLayout(0);
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(0);
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(5);
  }

  Widget _buildLayout(double memberDeletionButtonPosition) {
    return widget.groupRoleType == GroupRoleType.admin
        ? _buildAdminProfileList()
        : _buildMembershipProfileList(memberDeletionButtonPosition);
  }

  Widget _buildAdminProfileList() {
    return MemberNameAndImageView(memberProfile: widget.memberProfile);
  }

  Widget _buildMembershipProfileList(double memberDeletionButtonPosition) {
    return Stack(
      children: [
        Positioned.fill(
          child: MemberNameAndImageView(memberProfile: widget.memberProfile),
        ),
        if (ref.watch(groupMemberDeleteModeProvider))
          Positioned(
            top: memberDeletionButtonPosition,
            right: memberDeletionButtonPosition,
            child: MemberDeletionButton(
              accountId: widget.memberProfile.accountId,
              groupId: widget.groupId,
            ),
          ),
      ],
    );
  }
}
