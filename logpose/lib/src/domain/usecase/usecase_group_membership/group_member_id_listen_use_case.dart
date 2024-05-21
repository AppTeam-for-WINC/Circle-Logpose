import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_membership_repository.dart';

import '../../../data/repository/database/group_membership_repository.dart';
import '../../interface/group_membership/i_group_member_id_listen_use_case.dart';

final groupMemberIdListenUseCaseProvider =
    Provider<IGroupMemberIdListenUseCase>((ref) {
  final memberRepository = ref.read(groupMembershipRepositoryProvider);

  return GroupMemberIdListenUseCase(memberRepository: memberRepository);
});

class GroupMemberIdListenUseCase implements IGroupMemberIdListenUseCase {
  GroupMemberIdListenUseCase({required this.memberRepository});

  final IGroupMembershipRepository memberRepository;

  @override
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
