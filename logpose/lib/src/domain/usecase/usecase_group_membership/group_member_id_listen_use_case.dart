import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../interface/i_group_membership_repository.dart';

import '../../providers/repository/group_membership_repository_provider.dart';

final groupMemberIdListenUseCaseProvider =
    Provider<GroupMemberIdListenUseCase>((ref) {
  final memberRepository = ref.read(groupMembershipRepositoryProvider);

  return GroupMemberIdListenUseCase(memberRepository: memberRepository);
});

class GroupMemberIdListenUseCase {
  GroupMemberIdListenUseCase({required this.memberRepository});

  final IGroupMembershipRepository memberRepository;

  Stream<List<String?>> listenAllMembershipIdList(String groupId) async* {
    try {
      yield* memberRepository.listenAllMembershipIdList(groupId);
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to listen membership ID list. ${e.message}',
      );
    }
  }
}
