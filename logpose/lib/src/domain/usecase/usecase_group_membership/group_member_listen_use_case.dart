import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_membership_repository.dart';

import '../../../data/repository/database/group_membership_repository.dart';

import '../../entity/group_membership.dart';
import '../../entity/user_profile.dart';

import '../../interface/group_membership/i_group_member_listen_use_case.dart';

final groupMemberListenUseCaseProvider =
    Provider<IGroupMemberListenUseCase>((ref) {
  final memberRepository = ref.read(groupMembershipRepositoryProvider);

  return GroupMemberListenUseCase(memberRepository: memberRepository);
});

class GroupMemberListenUseCase implements IGroupMemberListenUseCase {
  GroupMemberListenUseCase({required this.memberRepository});

  final IGroupMembershipRepository memberRepository;

  @override
  Stream<List<UserProfile?>> listenAllMember(String groupId) async* {
    try {
      yield* memberRepository.listenAllMember(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error to watch membership profile. ${e.message}');
    }
  }

  @override
  Stream<List<GroupMembership?>> listenAllMembershipListWithUserId(
    String userDocId,
  ) async* {
    try {
      yield* memberRepository.listenAllMembershipListWithUserId(userDocId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to watch user ID. ${e.message}');
    }
  }
}
