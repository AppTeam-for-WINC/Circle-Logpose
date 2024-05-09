import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../../../../models/database/user/user.dart';
import '../../../../services/database/group_membership_controller.dart';

class GroupRoleProfileFuture {
  GroupRoleProfileFuture._internal();
  static final GroupRoleProfileFuture _instance =
      GroupRoleProfileFuture._internal();
  static GroupRoleProfileFuture get instance => _instance;

  Future<List<UserProfile?>> fetchMembershipProfile(String groupId) async {
    try {
      return await GroupMembershipController
          .watchAllUserProfileWithGroupIdAndRole(
        groupId,
        'membership',
      ).first;
    } on FirebaseException catch (e) {
      debugPrint('Error to watch membership profile. $e');
      return [];
    } on Exception catch (e) {
      throw Exception('Failed to fetch membership profiles. $e');
    }
  }
}
