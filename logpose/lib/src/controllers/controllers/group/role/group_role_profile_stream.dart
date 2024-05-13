import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../../../../models/database/user/user.dart';

import '../../../../server/database/group_membership_controller.dart';

class GroupRoleProfileStream {
  GroupRoleProfileStream._internal();
  static final GroupRoleProfileStream _instance =
      GroupRoleProfileStream._internal();
  static GroupRoleProfileStream get instance => _instance;

  Stream<List<UserProfile?>> watchAdminProfile(String groupId) async* {
    try {
      yield* GroupMembershipController.watchAllUserProfileWithGroupIdAndRole(
        groupId,
        'admin',
      );
    } on FirebaseException catch (e) {
      debugPrint('Error to watch admin profile. $e');
    }
  }

  Stream<List<UserProfile?>> watchMembershipProfile(String groupId) async* {
    try {
      yield* GroupMembershipController.watchAllUserProfileWithGroupIdAndRole(
        groupId,
        'membership',
      );
    } on FirebaseException catch (e) {
      debugPrint('Error to watch membership profile. $e');
    }
  }

  Stream<List<UserProfile?>> watchMemberProfile(String groupId) async* {
    try {
      yield* GroupMembershipController.watchAllUserProfileWithGroupId(groupId);
    } on FirebaseException catch (e) {
      debugPrint('Error to watch membership profile. $e');
    }
  }
}
