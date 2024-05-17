import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../interface/i_group_schedule_repository.dart';

import '../../providers/repository/group_schedule_repository_provider.dart';

final groupIdWithScheduleIdUseCaseProvider =
    Provider<GroupIdWithScheduleIdUseCase>(
  (ref) {
    final groupScheduleRepository = ref.read(groupScheduleRepositoryProvider);

    return GroupIdWithScheduleIdUseCase(
      groupScheduleRepository: groupScheduleRepository,
    );
  },
);

class GroupIdWithScheduleIdUseCase {
  const GroupIdWithScheduleIdUseCase({required this.groupScheduleRepository});

  final IGroupScheduleRepository groupScheduleRepository;

  Future<String> fetchGroupIdWithScheduleId(String scheduleId) async {
    try {
      return await groupScheduleRepository.fetchGroupId(scheduleId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group ID. ${e.message}');
    }
  }
}
