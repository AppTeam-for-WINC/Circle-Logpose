import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_schedule_repository.dart';

import '../../../data/repository/database/group_schedule_repository.dart';

import '../../entity/group_schedule.dart';
import '../../interface/group_schedule/i_group_schedule_use_case.dart';

final groupScheduleUseCaseProvider = Provider<IGroupScheduleUseCase>((ref) {
  final scheduleRepository = ref.read(groupScheduleRepositoryProvider);
  return GroupScheduleUseCase(scheduleRepository: scheduleRepository);
});

class GroupScheduleUseCase implements IGroupScheduleUseCase {
  const GroupScheduleUseCase({required this.scheduleRepository});

  final IGroupScheduleRepository scheduleRepository;

  @override
  Future<GroupSchedule> fetchGroupSchedule(String groupScheduleId) async {
    return scheduleRepository.fetchGroupSchedule(groupScheduleId);
  }
}
