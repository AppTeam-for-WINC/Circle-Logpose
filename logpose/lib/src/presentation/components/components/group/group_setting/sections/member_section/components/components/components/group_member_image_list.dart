import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../notifiers/group_member_image_list_notifier.dart';
import '../../../../../../../../common/group_member_tile/group_member_tile.dart';

class GroupMemberImageList extends ConsumerWidget {
  const GroupMemberImageList({
    super.key,
    required this.role,
    required this.groupId,
  });

  final GroupRoleType role;
  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageList =
        ref.watch(groupMemberImageListNotifierProvider((role, groupId)));

    return imageList.isEmpty
        ? const SizedBox.shrink()
        : Row(children: imageList);
  }
}
