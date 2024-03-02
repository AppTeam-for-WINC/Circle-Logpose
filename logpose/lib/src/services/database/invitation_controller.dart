import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../models/group/database/invitation.dart';

import '../../utils/time/time_utils.dart';

class GroupInvitationController {
  GroupInvitationController._internal();
  static final GroupInvitationController _instance =
      GroupInvitationController._internal();
  static GroupInvitationController get instance => _instance;

  static final db = FirebaseFirestore.instance;

  static const collectionPath = 'group_invitations';

  ///Create invitation link, and return group invitation info.
  static Future<GroupInvitation> create(String groupId) async {
    final groupInvitationDoc = db.collection(collectionPath).doc();

    const baseURL = 'https://ama.com/invite';
    String link;
    while (true) {
      link = const Uuid().v4();
      final linkSnapshot = await db
          .collection(collectionPath)
          .where('invitation_link', isEqualTo: link)
          .get();
      if (linkSnapshot.docs.isEmpty) {
        break;
      }
    }

    ///Create invitation link.
    final invitationLink = '$baseURL?code=$link';

    ///Set Expires limit.
    final expiresAt = convertTimestampToTimestamp(
      DateTime.now().add(const Duration(days: 7)),
    );

    final createdAt = FieldValue.serverTimestamp();

    await groupInvitationDoc.set({
      'group_id': groupId,
      'invitation_link': invitationLink,
      'expires_at': expiresAt,
      'created_at': createdAt,
    });

    final groupInvitationData = await read(groupInvitationDoc.id);

    return groupInvitationData;
  }

  static Future<GroupInvitation> read(String docId) async {
    final invitationDoc = await db.collection(collectionPath).doc(docId).get();
    final invitationDocRef = invitationDoc.data();
    if (invitationDocRef == null) {
      throw Exception('Error : No found document data.');
    }

    final groupId = invitationDocRef['group_id'] as String;
    final invitationLink = invitationDocRef['invitation_link'] as String;
    final expiresAt = invitationDocRef['expires_at'] as Timestamp;
    final createdAt = invitationDocRef['created_at'] as Timestamp;

    return GroupInvitation(
      groupId: groupId,
      invitationLink: invitationLink,
      expiresAt: expiresAt,
      createdAt: createdAt,
    );
  }

  ///Delete Invitation link.
  static Future<void> delete(String docId) async {
    await db.collection(collectionPath).doc(docId).delete();
  }
}
