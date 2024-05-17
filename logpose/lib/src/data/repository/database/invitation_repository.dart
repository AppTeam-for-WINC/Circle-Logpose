import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/interface/i_group_invitation_repository.dart';

import '../../../utils/time/time_utils.dart';

import '../../models/invitation.dart';

class GroupInvitationRepository implements IGroupInvitationRepository {
  GroupInvitationRepository._internal();
  static final GroupInvitationRepository _instance =
      GroupInvitationRepository._internal();
  static GroupInvitationRepository get instance => _instance;

  static final db = FirebaseFirestore.instance;
  static const collectionPath = 'group_invitations';

  // To-do modified link.
  @override
  Future<GroupInvitation> create(String groupId) async {
    try {
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

      /// Create invitation link.
      final invitationLink = '$baseURL?code=$link';

      /// Set Expires limit.
      final expiresAt = convertTimestampToTimestamp(
        DateTime.now().add(const Duration(days: 7)),
      );
      
      await groupInvitationDoc.set({
        'group_id': groupId,
        'invitation_link': invitationLink,
        'expires_at': expiresAt,
        'created_at': FieldValue.serverTimestamp(),
      });

      return fetch(groupInvitationDoc.id);
    } on FirebaseException catch (e) {
      throw Exception('Error: Failed to create invitation link. ${e.message}');
    }
  }

  @override
  Future<GroupInvitation> fetch(String docId) async {
    try {
      final data =
          (await db.collection(collectionPath).doc(docId).get()).data();
      if (data == null) {
        throw Exception('Error : No found document data.');
      }

      return GroupInvitation.fromMap(data);
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to fetch group invitation data. ${e.message}',
      );
    }
  }

  @override
  Future<void> delete(String docId) async {
    try {
      await db.collection(collectionPath).doc(docId).delete();
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to delete group invitation link. ${e.message}',
      );
    }
  }
}
