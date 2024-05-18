import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/database/group_invitation_repository.dart';

import '../../interface/i_group_invitation_repository.dart';

final groupInvitationUseCaseProvider = Provider<GroupInvitationUseCase>((ref) {
  final groupInvitationRepository = ref.read(groupInvitationRepositoryProvider);

  return GroupInvitationUseCase(
    groupInvitationRepository: groupInvitationRepository,
  );
});

class GroupInvitationUseCase {
  const GroupInvitationUseCase({required this.groupInvitationRepository});

  final IGroupInvitationRepository groupInvitationRepository;

  Future<String> createAndFetchGroupInvitationLink(String groupId) async {
    try {
      final data = await groupInvitationRepository.create(groupId);
      return data.invitationLink;
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch invitation link. ${e.message}');
    }
  }
}
