import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/user_profile.dart';

import '../notifiers/group_member_list_setter_notifier.dart';
import '../notifiers/search_user_notifier.dart';

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
        .watch(groupMemberListSetterNotifierProvider.notifier)
        .addMember(userProfile);
  }
}
