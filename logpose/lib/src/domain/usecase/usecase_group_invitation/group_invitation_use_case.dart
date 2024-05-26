import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_invitation_repository.dart';

import '../../../data/repository/database/group_invitation_repository.dart';
import '../../interface/group_invitation/i_group_invitation_use_case.dart';

final groupInvitationUseCaseProvider = Provider<IGroupInvitationUseCase>((ref) {
  final groupInvitationRepository = ref.read(groupInvitationRepositoryProvider);

  return GroupInvitationUseCase(
    groupInvitationRepository: groupInvitationRepository,
  );
});

class GroupInvitationUseCase implements IGroupInvitationUseCase {
  const GroupInvitationUseCase({required this.groupInvitationRepository});

  final IGroupInvitationRepository groupInvitationRepository;

  @override
  Future<String> createAndFetchGroupInvitationLink(String groupId) async {
    try {
      final data = await groupInvitationRepository.create(groupId);
      return data.invitationLink;
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch invitation link. ${e.message}');
    }
  }
}
