import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../domain/providers/group/members/watch_group_admin_profile_list_provider.dart';
import '../../../../../../../../domain/providers/group/members/watch_group_member_profile_list_provider.dart';

import '../../../../../../common/custom_image/custom_image.dart';

class GroupMemberImageList extends ConsumerStatefulWidget {
  const GroupMemberImageList({
    super.key,
    required this.role,
    required this.groupId,
  });
  final String role;
  final String groupId;

  @override
  ConsumerState<GroupMemberImageList> createState() =>
      _GroupMemberImageListState();
}

class _GroupMemberImageListState extends ConsumerState<GroupMemberImageList> {
  @override
  Widget build(BuildContext context) {
    final role = widget.role;

    if (role == 'admin') {
      final groupAdminProfileList =
          ref.watch(watchGroupAdminProfileListProvider(widget.groupId));

      return groupAdminProfileList.when(
        data: (adminProfiles) {
          return Column(
            children: adminProfiles.map((adminProfile) {
              return adminProfile != null
                  ? CustomImage(
                      imagePath: adminProfile.image,
                      width: 30,
                      height: 30,
                    )
                  : const SizedBox.shrink();
            }).toList(),
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (error, stack) => Text('$error'),
      );
    } else if (role == 'membership') {
      final groupMembershipProfileList =
          ref.watch(watchGroupMembershipProfileListProvider(widget.groupId));
      return groupMembershipProfileList.when(
        data: (membershipProfiles) {
          return Row(
            children: membershipProfiles.map((membershipProfile) {
              return membershipProfile != null
                  ? CustomImage(
                      imagePath: membershipProfile.image,
                      width: 30,
                      height: 30,
                    )
                  : const SizedBox.shrink();
            }).toList(),
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (error, stack) => Text('$error'),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
