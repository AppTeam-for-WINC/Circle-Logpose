import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../interface/i_group_membership_repository.dart';
import '../../interface/i_user_repository.dart';

import '../../providers/repository/group_membership_repository_provider.dart';
import '../../providers/repository/user_repository_provider.dart';
import 'group_member_id_use_case.dart';

final groupMemberDeleteUseCaseProvider = Provider<GroupMemberDeleteUseCase>(
  (ref) {
    final memberRepository = ref.read(groupMembershipRepositoryProvider);
    final userRepository = ref.read(userRepositoryProvider);
    final groupMemberIdUseCase = ref.read(groupMemberIdUseCaseProvider);

    return GroupMemberDeleteUseCase(
      memberRepository: memberRepository,
      userRepository: userRepository,
      groupMemberIdUseCase: groupMemberIdUseCase,
    );
  },
);

class GroupMemberDeleteUseCase {
  const GroupMemberDeleteUseCase({
    required this.userRepository,
    required this.memberRepository,
    required this.groupMemberIdUseCase,
  });

  final IUserRepository userRepository;
  final IGroupMembershipRepository memberRepository;
  final GroupMemberIdUseCase groupMemberIdUseCase;

  Future<void> deleteMember(String membershipDocId) async {
    try {
      await memberRepository.delete(membershipDocId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete member. ${e.message}');
    }
  }

  Future<void> deleteMemberWithGroupIdAndAccountId(
    String groupId,
    String accountId,
  ) async {
    try {
      await _attemptToDeleteMember(groupId, accountId);
    } on Exception catch (e) {
      throw Exception('Error: failed to delete member. $e');
    }
  }

  Future<void> _attemptToDeleteMember(String groupId, String accountId) async {
    final membershipDocId = await _fetchMembershipIdWithGroupIdAndUserId(
      groupId,
      accountId,
    );
    await deleteMember(membershipDocId);
  }

  Future<String> _fetchMembershipIdWithGroupIdAndUserId(
    String groupId,
    String accountId,
  ) async {
    return groupMemberIdUseCase.fetchMembershipIdWithGroupIdAndUserId(
      groupId,
      accountId,
    );
  }
}
