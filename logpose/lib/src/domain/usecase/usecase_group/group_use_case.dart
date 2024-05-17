import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/group_profile.dart';

import '../../interface/i_group_repository.dart';

import '../../providers/repository/group_repository_provider.dart';

final groupUseCaseProvider = Provider<GroupUseCase>((ref) {
  final groupRepository = ref.read(groupRepositoryProvider);

  return GroupUseCase(groupRepository: groupRepository);
});

class GroupUseCase {
  const GroupUseCase({required this.groupRepository});

  final IGroupRepository groupRepository;

  Future<GroupProfile> fetchGroup(String groupId) async {
    try {
      return await groupRepository.fetchGroup(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group. ${e.message}');
    }
  }
}
