import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_schedule_repository.dart';

import '../../../data/repository/database/group_schedule_repository.dart';
import '../../interface/group_schedule/i_group_schedule_listen_id_use_case.dart';

final groupScheduleListenIdUseCaseProvider =
    Provider<IGroupScheduleListenIdUseCase>((ref) {
  final groupScheduleRepository = ref.read(groupScheduleRepositoryProvider);

  return GroupScheduleListenIdUseCase(
    groupScheduleRepository: groupScheduleRepository,
  );
});

class GroupScheduleListenIdUseCase implements IGroupScheduleListenIdUseCase {
  const GroupScheduleListenIdUseCase({required this.groupScheduleRepository});

  final IGroupScheduleRepository groupScheduleRepository;

  @override
  Stream<List<String?>> listenAllScheduleId(String groupId) async* {
    try {
      yield* groupScheduleRepository.listenAllScheduleId(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to listen all schedule ID. ${e.message}');
    }
  }
}
