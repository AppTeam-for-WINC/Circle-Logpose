import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../interface/i_group_member_schedule_repository.dart';
import '../../interface/i_group_membership_repository.dart';

import '../../providers/repository/group_member_schedule_repository_provider.dart';
import '../../providers/repository/group_membership_repository_provider.dart';
import '../usecase_user/user_id_use_case.dart';

final groupMemberIdUseCaseProvider = Provider<GroupMemberIdUseCase>((ref) {
  final userIdUseCase = ref.read(userIdUseCaseProvider);
  final memberRepository = ref.read(groupMembershipRepositoryProvider);
  final memberScheduleRepository =
      ref.read(groupMemberScheduleRepositoryProvider);

  return GroupMemberIdUseCase(
    ref: ref,
    userIdUseCase: userIdUseCase,
    memberRepository: memberRepository,
    memberScheduleRepository: memberScheduleRepository,
  );
});

class GroupMemberIdUseCase {
  const GroupMemberIdUseCase({
    required this.ref,
    required this.userIdUseCase,
    required this.memberRepository,
    required this.memberScheduleRepository,
  });

  final Ref ref;
  final UserIdUseCase userIdUseCase;
  final IGroupMembershipRepository memberRepository;
  final IGroupMemberScheduleRepository memberScheduleRepository;

  Future<String?> fetchMembershipIdWithScheduleIdAndUserId(
    String scheduleId,
    String userId,
  ) async {
    try {
      return await memberScheduleRepository
          .fetchMembershipIdWithScheduleIdAndUserId(
        scheduleId,
        userId,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user ID. ${e.message}');
    }
  }

  Future<List<String>> fetchAllMembershipIdList(String groupId) async {
    try {
      return await memberRepository.listenAllMembershipIdList(groupId).first;
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to fetch all member ID list. ${e.message}',
      );
    }
  }

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
