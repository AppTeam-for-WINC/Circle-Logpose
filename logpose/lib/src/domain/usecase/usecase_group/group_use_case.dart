import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_repository.dart';

import '../../../data/repository/database/group_repository.dart';

import '../../entity/group_profile.dart';

import '../../interface/group/i_group_use_case.dart';

final groupUseCaseProvider = Provider<IGroupUseCase>((ref) {
  final groupRepository = ref.read(groupRepositoryProvider);

  return GroupUseCase(groupRepository: groupRepository);
});

class GroupUseCase implements IGroupUseCase{
  const GroupUseCase({required this.groupRepository});

  final IGroupRepository groupRepository;

  @override
  Future<GroupProfile> fetchGroup(String groupId) async {
    try {
      return await groupRepository.fetchGroup(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group. ${e.message}');
    }
  }
}
