import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/user.dart';

import '../../interface/i_group_membership_repository.dart';

import '../../providers/repository/group_membership_repository_provider.dart';

final groupMemberListenUseCaseProvider =
    Provider<GroupMemberListenUseCase>((ref) {
  final memberRepository = ref.read(groupMembershipRepositoryProvider);

  return GroupMemberListenUseCase(memberRepository: memberRepository);
});

class GroupMemberListenUseCase {
  GroupMemberListenUseCase({required this.memberRepository});

  final IGroupMembershipRepository memberRepository;

  Stream<List<UserProfile?>> listenAllMember(String groupId) async* {
    try {
      yield* memberRepository.listenAllMember(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error to watch membership profile. ${e.message}');
    }
  }
}
