import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_membership_repository.dart';

import '../../../data/repository/database/group_membership_repository.dart';

import '../../entity/user_profile.dart';

import '../../interface/group_membership/i_group_member_listen_by_role_use_case.dart';

final groupMemberListenByRoleUseCaseProvider =
    Provider<IGroupMemberListenByRoleUseCase>((ref) {
  final memberRepository = ref.read(groupMembershipRepositoryProvider);
  return GroupMemberListenByRoleUseCase(
    ref: ref,
    memberRepository: memberRepository,
  );
});

class GroupMemberListenByRoleUseCase
    implements IGroupMemberListenByRoleUseCase {
  const GroupMemberListenByRoleUseCase({
    required this.ref,
    required this.memberRepository,
  });

  final Ref ref;
  final IGroupMembershipRepository memberRepository;

  @override
  Stream<List<UserProfile?>> listenAllAdminProfile(String groupId) async* {
    try {
      yield* memberRepository.listenAllUserProfileWithGroupIdAndRole(
        groupId,
        'admin',
      );
    } on FirebaseException catch (e) {
      throw Exception('Error to watch admin profile. ${e.message}');
    }
  }

  @override
  Stream<List<UserProfile?>> listenAllMembershipProfile(String groupId) async* {
    try {
      yield* memberRepository.listenAllUserProfileWithGroupIdAndRole(
        groupId,
        'membership',
      );
    } on FirebaseException catch (e) {
      throw Exception('Error to watch membership profile. ${e.message}');
    }
  }
}
