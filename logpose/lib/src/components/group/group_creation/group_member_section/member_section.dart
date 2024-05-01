import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controllers/providers/group/members/membership/set_group_member_list_provider.dart';
import '../../../../controllers/providers/user/user_profile_provider.dart';
import '../../group_member_tile/group_member_tile.dart';

class MemberSection extends ConsumerStatefulWidget {
  const MemberSection({super.key});

  @override
  ConsumerState createState() => _MemberSectionState();
}

class _MemberSectionState extends ConsumerState<MemberSection> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: deviceWidth * 0.85,
      height: deviceHeight * 0.41,
      margin: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: CupertinoColors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 2.2,
            spreadRadius: 2.2,
            offset: Offset(0, 3),
            color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 20,
              left: 30,
              bottom: 10,
            ),
            child: const Text(
              'メンバー',
              style: TextStyle(color: CupertinoColors.systemGrey),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: GridView.count(
                crossAxisSpacing: 26,
                mainAxisSpacing: 14,
                childAspectRatio: 2.5,
                crossAxisCount: 2,
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                children: <Widget>[
                  ref.watch(readUserProfileProvider).when(
                    data: (adminUserProfile) {
                      return GroupMemberTile(
                        memberProfile: adminUserProfile,
                        adminOrMembership: 'admin',
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (error, stack) => Text('$error'),
                  ),
                  ...ref.watch(setGroupMemberListProvider).map(
                        (memberProfile) => GroupMemberTile(
                          memberProfile: memberProfile,
                          adminOrMembership: 'membership',
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
