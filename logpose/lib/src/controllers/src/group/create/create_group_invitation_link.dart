import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../services/database/invitation_controller.dart';

class CreateGroupInvitationLink {
  CreateGroupInvitationLink._internal();
  static final CreateGroupInvitationLink _instance =
      CreateGroupInvitationLink._internal();
  static CreateGroupInvitationLink get instance => _instance;

  static Future<String?> readGroupInvitationLink(String groupId) async {
    try {
      return (await GroupInvitationController.create(groupId)).invitationLink;
    } on FirebaseException catch (e) {
      throw Exception('Failed to read invitation link. $e');
    }
  }
}
