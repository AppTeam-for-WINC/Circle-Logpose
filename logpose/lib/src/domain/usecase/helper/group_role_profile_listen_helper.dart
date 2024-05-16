import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/database/user/user.dart';

import '../../providers/group/group/group_membership_controller_provider.dart';

class GroupRoleProfileListenHelper {
  const GroupRoleProfileListenHelper({required this.ref});
  final Ref ref;

  Stream<List<UserProfile?>> listenAllAdminProfile(String groupId) async* {
    try {
      final memberRepository = ref.read(groupMembershipRepositoryProvider);
      yield* memberRepository.listenAllUserProfileWithGroupIdAndRole(
        groupId,
        'admin',
      );
    } on FirebaseException catch (e) {
      throw Exception('Error to watch admin profile. ${e.message}');
    }
  }

  Stream<List<UserProfile?>> listenAllMembershipProfile(String groupId) async* {
    try {
      final memberRepository = ref.read(groupMembershipRepositoryProvider);
      yield* memberRepository.listenAllUserProfileWithGroupIdAndRole(
        groupId,
        'membership',
      );
    } on FirebaseException catch (e) {
      throw Exception('Error to watch membership profile. ${e.message}');
    }
  }
}
