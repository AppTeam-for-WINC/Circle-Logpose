import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../server/database/invitation_controller.dart';

class GroupInvitationLinkService {
  const GroupInvitationLinkService();

  static Future<String?> fetchGroupInvitationLink(String groupId) async {
    try {
      final data = await GroupInvitationController.create(groupId);
      return data.invitationLink;
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to read invitation link. ${e.message}');
    }
  }
}
