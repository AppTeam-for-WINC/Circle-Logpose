import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../services/database/invitation_controller.dart';

class CreateGroupInvitationLink {
  CreateGroupInvitationLink._internal();
  static final CreateGroupInvitationLink _instance =
      CreateGroupInvitationLink._internal();
  static CreateGroupInvitationLink get instance => _instance;

  static Future<String?> readGroupInvitationLink(String groupId) async {
    try {
      final invitationData = await GroupInvitationController.create(groupId);
      final invitationLink = invitationData.invitationLink;
      return invitationLink;
    } on FirebaseException catch (e) {
      throw Exception('Failed to read invitation link. $e');
    }
  }
}
