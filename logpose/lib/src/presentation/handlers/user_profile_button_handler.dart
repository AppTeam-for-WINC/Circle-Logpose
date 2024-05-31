import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/user_profile.dart';

import '../notifiers/search_user_notifier_provider.dart';
import '../notifiers/set_group_member_list_notifier.dart';

class UserProfileButtonHandler {
  UserProfileButtonHandler({
    required this.ref,
    required this.groupId,
    required this.userProfile,
  });

  final WidgetRef ref;
  final String? groupId;
  final UserProfile userProfile;

  void handleToAddMember() {
    ref.watch(searchUserNotifierProvider(groupId).notifier).setMemberState();
    ref
        .watch(setGroupMemberListNotifierProvider.notifier)
        .addMember(userProfile);
  }
}
