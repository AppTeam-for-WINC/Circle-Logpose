import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controllers/providers/group/member/set_group_member_list_provider.dart';
import '../../../../controllers/providers/user/set_search_user_data_provider.dart';
import 'profile/user_image.dart';
import 'profile/user_name.dart';

class UserProfileButton extends ConsumerStatefulWidget {
  const UserProfileButton({
    super.key,
    required this.groupId,
  });
  final String? groupId;
  @override
  ConsumerState<UserProfileButton> createState() => _UserProfileButtonState();
}

class _UserProfileButtonState extends ConsumerState<UserProfileButton> {
  @override
  Widget build(BuildContext context) {
    final groupId = widget.groupId;

    // userProfileは、値の変化の追跡を行うが、変更を適用させることはない。
    final userProfile = ref.watch(setSearchUserDataProvider(groupId));
    if (userProfile == null) {
      return const SizedBox.shrink();
    }

    // userProfileNotifierは、値の変更を行うが、追跡は行わない。
    final userProfileNotifier =
        ref.watch(setSearchUserDataProvider(groupId).notifier);

    void handlAddMember() {
      ref.read(setSearchUserDataProvider(groupId).notifier).setMemberState();
      ref.read(setSearchUserDataProvider(groupId).notifier).resetState();
      ref.read(setGroupMemberListProvider.notifier).addMember(userProfile);
    }

      return Container(
        padding: const EdgeInsets.only(
          left: 20,
          top: 10,
          right: 20,
          bottom: 10,
        ),
        color: const Color(0xFFF5F3FE),
        child: Container(
          height: 60,
          width: 200,
          padding: const EdgeInsets.only(left: 5, right: 5),
          margin: const EdgeInsets.only(top: 15),
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
            onPressed: handlAddMember,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                UserImage(imageUrl: userProfile.image),     
                UserName(username: userProfileNotifier.username!),          
              ],
            ),
          ),
        ),
      );
  }
}
