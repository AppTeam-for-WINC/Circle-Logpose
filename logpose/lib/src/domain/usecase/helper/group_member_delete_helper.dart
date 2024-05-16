import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/repository/database/group_membership_repository.dart';
import '../../../data/repository/database/user_repository.dart';

// Used with group_member_deleter_provider.
class GroupMemberDeleteHelper {
  const GroupMemberDeleteHelper({
    required this.userRepository,
    required this.memberRepository,
  });
  final UserRepository userRepository;
  final GroupMembershipRepository memberRepository;

  Future<void> deleteMemberWithGroupIdAndAccountId(
    String groupId,
    String accountId,
  ) async {
    try {
      await _attemptToDeleteMember(groupId, accountId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete group schedule. ${e.message}');
    }
  }

  Future<void> _attemptToDeleteMember(String groupId, String accountId) async {
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
      return await memberRepository
          .fetchMemberDocIdWithGroupIdAndUserId(groupId, userDocId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch membership ID. ${e.message}');
    }
  }

  Future<String> _fetchUserDocId(String accountId) async {
    try {
      return await userRepository.fetchUserDocIdWithAccountId(accountId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user ID. ${e.message}');
    }
  }

  Future<void> _deleteMember(String membershipDocId) async {
    try {
      await memberRepository.delete(membershipDocId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete member. ${e.message}');
    }
  }
}
