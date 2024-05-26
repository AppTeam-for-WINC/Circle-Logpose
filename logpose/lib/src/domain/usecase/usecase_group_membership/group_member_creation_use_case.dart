import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_membership_repository.dart';

import '../../../data/repository/database/group_membership_repository.dart';

import '../../entity/user_profile.dart';

import '../../interface/group_membership/i_group_member_creation_use_case.dart';
import '../../interface/user/i_user_id_use_case.dart';

import '../usecase_user/user_id_use_case.dart';

final groupMemberCreationUseCaseProvider =
    Provider<IGroupMemberCreationUseCase>((ref) {
  final userIdUseCase = ref.read(userIdUseCaseProvider);
  final memberRepository = ref.read(groupMembershipRepositoryProvider);

  return GroupMemberCreationUseCase(
    ref: ref,
    userIdUseCase: userIdUseCase,
    memberRepository: memberRepository,
  );
});

class GroupMemberCreationUseCase implements IGroupMemberCreationUseCase {
  const GroupMemberCreationUseCase({
    required this.ref,
    required this.userIdUseCase,
    required this.memberRepository,
  });

  final Ref ref;
  final IUserIdUseCase userIdUseCase;
  final IGroupMembershipRepository memberRepository;

  @override
  Future<void> createAdminRole(String userDocId, String groupId) async {
    try {
      await memberRepository.createMemmbership(userDocId, 'admin', groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create admin role. ${e.message}');
    }
  }

  @override
  Future<void> createMembershipRole(
    String memberDocId,
    String groupId,
  ) async {
    try {
      await memberRepository.createMemmbership(
        memberDocId,
        'membership',
        groupId,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create membership role. ${e.message}');
    }
  }

  @override
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
    return userIdUseCase.fetchUserDocIdWithAccountId(accountId);
  }
}
