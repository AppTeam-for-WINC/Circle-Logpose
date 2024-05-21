import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_membership_repository.dart';

import '../../../data/repository/database/group_membership_repository.dart';

import '../../interface/group_membership/i_group_member_id_use_case.dart';
import '../../interface/user/i_user_id_use_case.dart';
import '../usecase_user/user_id_use_case.dart';

final groupMemberIdUseCaseProvider = Provider<IGroupMemberIdUseCase>((ref) {
  final userIdUseCase = ref.read(userIdUseCaseProvider);
  final memberRepository = ref.read(groupMembershipRepositoryProvider);

  return GroupMemberIdUseCase(
    ref: ref,
    userIdUseCase: userIdUseCase,
    memberRepository: memberRepository,
  );
});

class GroupMemberIdUseCase implements IGroupMemberIdUseCase {
  const GroupMemberIdUseCase({
    required this.ref,
    required this.userIdUseCase,
    required this.memberRepository,
  });

  final Ref ref;
  final IUserIdUseCase userIdUseCase;
  final IGroupMembershipRepository memberRepository;

  @override
  Future<String> fetchUserIdWithMembershipId(String membershipId) async {
    try {
      return await memberRepository.fetchUserIdWithMembershipId(membershipId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch membership ID. ${e.message}');
    }
  }

  @override
  Future<List<String>> fetchAllUserDocIdWithGroupId(String groupId) async {
    try {
      return await memberRepository.fetchAllUserDocIdWithGroupId(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch all user doc Id. ${e.message}');
    }
  }

  @override
  Future<List<String>> fetchAllMembershipIdList(String groupId) async {
    try {
      return await memberRepository.listenAllMembershipIdList(groupId).first;
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to fetch all member ID list. ${e.message}',
      );
    }
  }

  @override
  Future<String> fetchMembershipIdWithGroupIdAndUserId(
    String groupId,
    String accountId,
  ) async {
    try {
      final userDocId = await _fetchUserDocIdWithAccountId(accountId);
      return await memberRepository.fetchMembershipIdWithGroupIdAndUserId(
        groupId,
        userDocId,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch membership ID. ${e.message}');
    }
  }

  Future<String> _fetchUserDocIdWithAccountId(String accountId) async {
    return userIdUseCase.fetchUserDocIdWithAccountId(accountId);
  }
}
