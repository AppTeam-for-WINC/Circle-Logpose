import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/database/group_repository.dart';

import '../../entity/group_profile.dart';
import '../../interface/i_group_repository.dart';
import '../../model/group_and_id_model.dart';

import 'group_and_id_use_case.dart';

final groupAndIdListenUseCaseProvider =
    Provider<GroupAndIdListenUseCase>((ref) {
  final groupAndIdUseCase = ref.read(groupAndIdUseCaseProvider);
  final groupRepository = ref.read(groupRepositoryProvider);

  return GroupAndIdListenUseCase(
    groupAndIdUseCase: groupAndIdUseCase,
    groupRepository: groupRepository,
  );
});

class GroupAndIdListenUseCase {
  const GroupAndIdListenUseCase({
    required this.groupAndIdUseCase,
    required this.groupRepository,
  });

  final GroupAndIdUseCase groupAndIdUseCase;
  final IGroupRepository groupRepository;

  Stream<GroupAndId?> listenGroupAndId(String groupId) {
    try {
      return _listenGroup(groupId).map((groupProfile) {
        if (groupProfile == null) {
          return null;
        }
        return GroupAndId(groupProfile: groupProfile, groupId: groupId);
      });
    } on Exception catch (e) {
      throw Exception('Failed to from GroupAndId. $e');
    }
  }

  Stream<GroupProfile?> _listenGroup(String groupId) {
    return groupRepository.listenGroup(groupId);
  }
}
