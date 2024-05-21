import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_membership_repository.dart';

import '../../../data/repository/database/group_membership_repository.dart';
import '../../interface/group_membership/i_group_member_exist_use_case.dart';

final groupMemberExistUseCaseProvider = Provider<IGroupMemberExistUseCase>(
  (ref) {
    final memberRepository = ref.read(groupMembershipRepositoryProvider);

    return GroupMemberExistUseCase(memberRepository: memberRepository);
  },
);

class GroupMemberExistUseCase implements IGroupMemberExistUseCase {
  const GroupMemberExistUseCase({required this.memberRepository});

  final IGroupMembershipRepository memberRepository;

  @override
  Future<bool> doesMemberExist(String groupId, String userId) async {
    try {
      return memberRepository.doesMemberExist(
        groupId: groupId,
        userDocId: userId,
      );
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to check whether member does exist. ${e.message}',
      );
    }
  }
}
