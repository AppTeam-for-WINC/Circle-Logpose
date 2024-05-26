import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_repository.dart';

import '../../../data/repository/database/group_repository.dart';

import '../../entity/group_profile.dart';

import '../../interface/group/i_group_and_id_listen_use_case.dart';

import '../../model/group_and_id_model.dart';

final groupAndIdListenUseCaseProvider =
    Provider<IGroupAndIdListenUseCase>((ref) {
  final groupRepository = ref.read(groupRepositoryProvider);

  return GroupAndIdListenUseCase(
    groupRepository: groupRepository,
  );
});

class GroupAndIdListenUseCase implements IGroupAndIdListenUseCase {
  const GroupAndIdListenUseCase({required this.groupRepository});

  final IGroupRepository groupRepository;

  @override
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
