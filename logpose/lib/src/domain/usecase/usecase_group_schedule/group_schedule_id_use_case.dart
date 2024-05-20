import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/database/group_schedule_repository.dart';

import '../../interface/i_group_schedule_repository.dart';

final groupScheduleIdUseCaseProvider = Provider<GroupScheduleIdUseCase>((ref) {
  final scheduleRepository = ref.read(groupScheduleRepositoryProvider);
  return GroupScheduleIdUseCase(scheduleRepository: scheduleRepository);
});

class GroupScheduleIdUseCase {
  const GroupScheduleIdUseCase({required this.scheduleRepository});

  final IGroupScheduleRepository scheduleRepository;

  Future<List<String?>> fetchAllGroupScheduleId(String groupId) async {
    try {
      return await scheduleRepository.fetchAllGroupScheduleId(groupId);
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to fetch group schedule ID list. ${e.message}',
      );
    }
  }
}
