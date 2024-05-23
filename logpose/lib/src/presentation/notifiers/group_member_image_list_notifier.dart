import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/user_profile.dart';

import '../../domain/providers/group/members/listen_group_admin_profile_list_provider.dart';
import '../../domain/providers/group/members/listen_group_member_profile_list_provider.dart';

import '../components/common/custom_image/custom_image.dart';

final groupMemberImageListNotifierProvider = StateNotifierProvider.family<
    GroupMemberImageListNotifier, List<Widget>, (String role, String groupId)>(
  (ref, args) => GroupMemberImageListNotifier(ref, args.$1, args.$2),
);

class GroupMemberImageListNotifier extends StateNotifier<List<Widget>> {
  GroupMemberImageListNotifier(this.ref, this.role, this.groupId) : super([]) {
    _memberProfileList();
  }

  final Ref ref;
  final String role;
  final String groupId;

  Future<void> _memberProfileList() async {
    if (role == 'admin') {
      await _buildAdminProfileList();
    } else if (role == 'membership') {
      await _buildMembershipProfileList();
    }
  }

  Future<void> _buildAdminProfileList() async {
    final asyncGroupAdminProfileList =
        await ref.read(listenGroupAdminProfileListProvider(groupId).future);

    state = _buildProfileImages(asyncGroupAdminProfileList);
  }

  Future<void> _buildMembershipProfileList() async {
    final asyncGroupMembershipProfileList = await ref
        .read(listenGroupMembershipProfileListProvider(groupId).future);

    state = _buildProfileImages(asyncGroupMembershipProfileList);
  }

  List<Widget> _buildProfileImages(List<UserProfile?> profiles) {
    return profiles.map((profile) {
      return profile != null
          ? CustomImage(
              imagePath: profile.image,
              width: 30,
              height: 30,
            )
          : const SizedBox.shrink();
    }).toList();
  }
}
