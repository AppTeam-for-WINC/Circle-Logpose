import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_membership_repository.dart';

import '../../../data/repository/database/group_membership_repository.dart';

import '../../interface/group_membership/i_group_member_delete_use_case.dart';
import '../../interface/group_membership/i_group_member_id_use_case.dart';

import 'group_member_id_use_case.dart';

final groupMemberDeleteUseCaseProvider = Provider<IGroupMemberDeleteUseCase>(
  (ref) {
    final groupMemberIdUseCase = ref.read(groupMemberIdUseCaseProvider);
    final memberRepository = ref.read(groupMembershipRepositoryProvider);

    return GroupMemberDeleteUseCase(
      groupMemberIdUseCase: groupMemberIdUseCase,
      memberRepository: memberRepository,
    );
  },
);

class GroupMemberDeleteUseCase implements IGroupMemberDeleteUseCase {
  const GroupMemberDeleteUseCase({
    required this.groupMemberIdUseCase,
    required this.memberRepository,
  });

  final IGroupMemberIdUseCase groupMemberIdUseCase;
  final IGroupMembershipRepository memberRepository;

  @override
  Future<void> deleteMember(String membershipDocId) async {
    try {
      await memberRepository.delete(membershipDocId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete member. ${e.message}');
    }
  }

  @override
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
    final membershipDocId = await _fetchMembershipIdWithGroupIdAndAccountId(
      groupId,
      accountId,
    );
    if (membershipDocId == null) {
      return;
    }
    await deleteMember(membershipDocId);
  }

  Future<String?> _fetchMembershipIdWithGroupIdAndAccountId(
    String groupId,
    String accountId,
  ) async {
    return groupMemberIdUseCase.fetchMembershipIdWithGroupIdAndAccountId(
      groupId,
      accountId,
    );
  }
}
