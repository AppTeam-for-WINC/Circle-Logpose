import 'package:amazon_app/database/group/invitation/invitation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class GroupInvitationController {
  const GroupInvitationController();
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
    final expiresAt = DateTime.now().add(const Duration(days: 7)) as Timestamp;

    final createdAt = FieldValue.serverTimestamp() as Timestamp;

    await groupInvitationDoc.set({
      'group_id': groupId,
      'invitation_link': invitationLink,
      'expires_at': expiresAt,
      'created_at': createdAt,
    });

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
