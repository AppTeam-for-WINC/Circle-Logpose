import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../interface/i_group_schedule_repository.dart';

import '../../providers/repository/group_schedule_repository_provider.dart';

import '../facade/group_member_schedule_facade.dart';

final groupScheduleListenIdUseCaseProvider =
    Provider<GroupScheduleListenIdUseCase>((ref) {
  final memberScheduleUseCase = ref.read(groupMemberScheduleFacadeProvider);
  final groupScheduleRepository = ref.read(groupScheduleRepositoryProvider);

  return GroupScheduleListenIdUseCase(
    memberScheduleUseCase: memberScheduleUseCase,
    groupScheduleRepository: groupScheduleRepository,
  );
});

class GroupScheduleListenIdUseCase {
  const GroupScheduleListenIdUseCase({
    required this.memberScheduleUseCase,
    required this.groupScheduleRepository,
  });

  final GroupMemberScheduleFacade memberScheduleUseCase;
  final IGroupScheduleRepository groupScheduleRepository;

  Stream<List<String?>> listenAllScheduleId(String groupId) async* {
    try {
      yield* groupScheduleRepository.listenAllScheduleId(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to listen all schedule ID. ${e.message}');
    }
  }
}
