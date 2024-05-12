import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../server/database/group_membership_controller.dart';
import '../../../../server/database/user_controller.dart';

// Delete Group Member.
class DeleteGroupMember {
  DeleteGroupMember._internal();
  static final DeleteGroupMember _instance = DeleteGroupMember._internal();
  static DeleteGroupMember get instance => _instance;

  static Future<void> delete(String groupId, String accountId) async {
    try {
      final membershipDocId = await _fetchGroupMembershipDocId(
        groupId,
        accountId,
      );
      await _deleteMembers(membershipDocId);
    } on FirebaseException catch (e) {
      throw Exception('Failed to delete group schedule. Error: $e');
    }
  }


  static Future<String> _fetchGroupMembershipDocId(
    String groupId,
    String accountId,
  ) async {
    final userDocId = await _fetchUserDocId(accountId);
    return GroupMembershipController.readMemberDocIdWithGroupIdAndUserId(
      groupId,
      userDocId,
    );
  }

  static Future<String> _fetchUserDocId(String accountId) async {
    return UserController.fetchUserDocIdWithAccountId(accountId);
  }

  static Future<void> _deleteMembers(String membershipDocId) async {
    await GroupMembershipController.delete(membershipDocId);
  }
}
