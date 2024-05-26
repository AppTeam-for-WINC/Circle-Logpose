import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_schedule_repository.dart';

import '../../../data/repository/database/group_schedule_repository.dart';
import '../../interface/group_schedule/i_group_schedule_id_use_case.dart';

final groupScheduleIdUseCaseProvider = Provider<IGroupScheduleIdUseCase>((ref) {
  final scheduleRepository = ref.read(groupScheduleRepositoryProvider);
  return GroupScheduleIdUseCase(scheduleRepository: scheduleRepository);
});

class GroupScheduleIdUseCase implements IGroupScheduleIdUseCase {
  const GroupScheduleIdUseCase({required this.scheduleRepository});

  final IGroupScheduleRepository scheduleRepository;

  @override
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
