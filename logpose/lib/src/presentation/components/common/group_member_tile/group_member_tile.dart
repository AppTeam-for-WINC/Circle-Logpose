import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entity/user_profile.dart';

import '../../../providers/group/mode/group_member_delete_mode_provider.dart';

import 'components/member_delete_button.dart';
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
    final deviceHeight = MediaQuery.of(context).size.height;
    final memberProfile = widget.memberProfile;
    final groupRoleType = widget.groupRoleType;

    Widget buildAdminProfileList() {
      return MemberNameAndImageView(memberProfile: memberProfile);
    }

    Widget buildMembershipProfileList() {
      return SizedBox(
        height: deviceHeight * 0.06,
        child: Stack(
          children: [
            Positioned.fill(
              child: MemberNameAndImageView(memberProfile: memberProfile),
            ),
            if (ref.watch(groupMemberDeleteModeProvider))
              Positioned(
                top: 0,
                right: 0,
                child: MemberDeleteButton(
                  accountId: memberProfile.accountId,
                  groupId: widget.groupId,
                ),
              ),
          ],
        ),
      );
    }

    if (groupRoleType == GroupRoleType.admin) {
      return buildAdminProfileList();
    } else if (groupRoleType == GroupRoleType.membership) {
      return buildMembershipProfileList();
    } else {
      return const SizedBox.shrink();
    }
  }
}
