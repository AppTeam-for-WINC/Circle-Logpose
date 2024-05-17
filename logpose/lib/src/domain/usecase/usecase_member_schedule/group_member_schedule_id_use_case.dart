import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/repository/group_member_schedule_repository_provider.dart';
import '../../providers/repository/group_membership_repository_provider.dart';

final groupMemberScheduleIdUseCaseProvider =
    Provider<GroupMemberScheduleIdUseCase>(
  (ref) => GroupMemberScheduleIdUseCase(ref: ref),
);

class GroupMemberScheduleIdUseCase {
  const GroupMemberScheduleIdUseCase({required this.ref});
  final Ref ref;

  Future<String> fetchMemberScheduleId(
    String groupScheduleId,
    String userDocId,
  ) async {
    try {
      final memberScheduleRepository =
          ref.read(groupMemberScheduleRepositoryProvider);

      return await memberScheduleRepository.fetchDocIdWithScheduleIdAndUserId(
        scheduleId: groupScheduleId,
        userDocId: userDocId,
      );
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to fetch member schedule ID. ${e.message}',
      );
    }
  }

  Future<List<String>> fetchAllUserDocIdWithGroupId(String groupId) async {
    try {
      final groupMembershipRepository =
          ref.read(groupMembershipRepositoryProvider);
      return await groupMembershipRepository
          .fetchAllUserDocIdWithGroupId(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch all user doc Id. ${e.message}');
    }
  }
}
