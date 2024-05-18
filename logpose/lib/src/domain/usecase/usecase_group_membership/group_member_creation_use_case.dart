import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/database/group_membership_repository.dart';
import '../../../data/repository/database/user_repository.dart';

import '../../entity/user_profile.dart';

final groupMemberCreationUseCaseProvider =
    Provider<GroupMemberCreationUseCase>(
  (ref) => GroupMemberCreationUseCase(ref: ref),
);

class GroupMemberCreationUseCase {
  const GroupMemberCreationUseCase({required this.ref});
  final Ref ref;

  Future<void> createAdminRole(String userDocId, String groupId) async {
    try {
      final memberRepository = ref.read(groupMembershipRepositoryProvider);
      await memberRepository.createMemmbership(userDocId, 'admin', groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create admin role. ${e.message}');
    }
  }

  Future<void> createMembershipRole(
    String memberDocId,
    String groupId,
  ) async {
    try {
      final memberRepository = ref.read(groupMembershipRepositoryProvider);
      await memberRepository.createMemmbership(
        memberDocId,
        'membership',
        groupId,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create membership role. ${e.message}');
    }
  }

  Future<void> createAllMembershipRole(
    String groupId,
    List<UserProfile> memberList,
  ) async {
    try {
      await _attemptToCreateAllMembershipsRole(groupId, memberList);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create membership roles. ${e.message}');
    } on Exception catch (e) {
      throw Exception('Error: failed to get group member list. $e');
    }
  }

  Future<void> _attemptToCreateAllMembershipsRole(
    String groupId,
    List<UserProfile> memberList,
  ) async {
    await Future.wait(
      memberList.map((member) async {
        await _createMembership(member.accountId, groupId);
      }),
    );
  }

  Future<void> _createMembership(String accountId, String groupId) async {
    final memberDocId = await _fetchMemberDocId(accountId);
    await createMembershipRole(memberDocId, groupId);
  }

  Future<String> _fetchMemberDocId(String accountId) async {
    try {
      final userRepository = ref.read(userRepositoryProvider);
      return await userRepository.fetchUserDocIdWithAccountId(accountId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user ID. ${e.message}');
    }
  }
}
