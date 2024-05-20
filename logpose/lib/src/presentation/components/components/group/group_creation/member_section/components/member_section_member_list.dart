import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../notifiers/member_section_admin_membersnotiifer.dart';
import '../../../../../../notifiers/set_group_member_list_notifier.dart';

import '../../../group_member_tile/group_member_tile.dart';

class MemberSectionMemberList extends ConsumerStatefulWidget {
  const MemberSectionMemberList({super.key});

  @override
  ConsumerState createState() => _MemberSectionMemberListState();
}

class _MemberSectionMemberListState
    extends ConsumerState<MemberSectionMemberList> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          height: deviceHeight * 0.3,
          child: GridView.count(
            mainAxisSpacing: 8,
            childAspectRatio: 5.5,
            crossAxisCount: 1,
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: <Widget>[
              ...ref.watch(memberSectionAdminMembersNotifierProvider),
              ...ref.watch(setGroupMemberListNotifierProvider).map(
                    (membershipUserProfile) => GroupMemberTile(
                      memberProfile: membershipUserProfile,
                      adminOrMembership: 'membership',
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
