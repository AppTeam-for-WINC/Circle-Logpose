import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_schedule_repository.dart';

import '../../../data/repository/database/group_schedule_repository.dart';

import '../../interface/group_schedule/i_group_id_with_schedule_id_use_case.dart';

final groupIdWithScheduleIdUseCaseProvider =
    Provider<IGroupIdWithScheduleIdUseCase>(
  (ref) {
    final groupScheduleRepository = ref.read(groupScheduleRepositoryProvider);

    return GroupIdWithScheduleIdUseCase(
      groupScheduleRepository: groupScheduleRepository,
    );
  },
);

class GroupIdWithScheduleIdUseCase implements IGroupIdWithScheduleIdUseCase {
  const GroupIdWithScheduleIdUseCase({required this.groupScheduleRepository});

  final IGroupScheduleRepository groupScheduleRepository;

  @override
  Future<String> fetchGroupIdWithScheduleId(String scheduleId) async {
    try {
      return await groupScheduleRepository.fetchGroupId(scheduleId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group ID. ${e.message}');
    }
  }
}
