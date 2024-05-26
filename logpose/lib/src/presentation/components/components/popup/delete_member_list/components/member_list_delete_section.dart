import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../notifiers/admin_member_tile_notifier.dart';
import '../../../../../notifiers/membership_member_tile_notifier.dart';
import '../../../../../notifiers/set_group_member_list_notifier.dart';

import '../../../../common/group_member_tile/group_member_tile.dart';

import 'components/member_list_delete_section_label.dart';

class MemberListDeleteSection extends ConsumerWidget {
  const MemberListDeleteSection({super.key, required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final adminMemberTile = ref.watch(adminMemberTileNotifierNotifierProvider);
    final membershipMemberTile =
        ref.watch(membershipMemberTileNotifierProvider(groupId));

    return Column(
      children: [
        const MemberListDeleteSectionLabel(),
        SingleChildScrollView(
          child: SizedBox(
            height: deviceHeight * 0.4,
            child: GridView.count(
              mainAxisSpacing: 8,
              childAspectRatio: 5.5,
              crossAxisCount: 1,
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              children: [
                adminMemberTile,
                membershipMemberTile,
                ...ref.watch(setGroupMemberListNotifierProvider).map(
                      (memberProfile) => GroupMemberTile(
                        memberProfile: memberProfile,
                        groupRoleType: GroupRoleType.membership,
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
