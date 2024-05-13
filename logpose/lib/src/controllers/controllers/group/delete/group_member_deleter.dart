import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../server/database/group_membership_controller.dart';
import '../../../../server/database/user_controller.dart';

// Used with group_member_deleter_provider.
class GroupMemberDeleter {
  const GroupMemberDeleter();
  Future<void> delete(String groupId, String accountId) async {
    try {
      await _attemptToDelete(groupId, accountId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete group schedule. ${e.message}');
    }
  }

  Future<void> _attemptToDelete(String groupId, String accountId) async {
    final membershipDocId = await _fetchGroupMembershipDocId(
      groupId,
      accountId,
    );
    await _deleteMember(membershipDocId);
  }

  Future<String> _fetchGroupMembershipDocId(
    String groupId,
    String accountId,
  ) async {
    try {
      final userDocId = await _fetchUserDocId(accountId);
      return await GroupMembershipController
          .fetchMemberDocIdWithGroupIdAndUserId(groupId, userDocId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch membership ID. ${e.message}');
    }
  }

  Future<String> _fetchUserDocId(String accountId) async {
    try {
      return UserController.fetchUserDocIdWithAccountId(accountId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user ID. ${e.message}');
    }
  }

  Future<void> _deleteMember(String membershipDocId) async {
    try {
      await GroupMembershipController.delete(membershipDocId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete member. ${e.message}');
    }
  }
}
