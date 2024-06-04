import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../utils/time_utils.dart';

import '../../../domain/entity/group_invitation.dart';

import '../../interface/i_group_invitation_repository.dart';

import '../../mapper/group_invitation_mapper.dart';

import '../../model/group_invitation_model.dart';

final groupInvitationRepositoryProvider = Provider<IGroupInvitationRepository>(
  (ref) => GroupInvitationRepository.instance,
);

/// After 2025/08~ Not supported.
class GroupInvitationRepository implements IGroupInvitationRepository {
  GroupInvitationRepository._internal();
  static final GroupInvitationRepository _instance =
      GroupInvitationRepository._internal();
  static GroupInvitationRepository get instance => _instance;

  static final db = FirebaseFirestore.instance;
  static const collectionPath = 'group_invitations';

  // To-do modified invitation correct link.
  @override
  Future<GroupInvitation> create(String groupId) async {
    try {
      final groupInvitationDoc = db.collection(collectionPath).doc();
      final linkCode = await _getLinkCode();
      final parameters = _setDynamicLinkParams(linkCode);
      final unguessableInvitationLink = await _buildInvitationLink(parameters);
      final expiresAt = _setExpireLimit();
      final linkPath = unguessableInvitationLink.shortUrl.toString();

      await groupInvitationDoc.set({
        'group_id': groupId,
        'invitation_link': linkPath,
        'expires_at': expiresAt,
        'created_at': FieldValue.serverTimestamp(),
      });

      return await fetch(groupInvitationDoc.id);
    } on FirebaseException catch (e) {
      throw Exception('Error: Failed to create invitation link. ${e.message}');
    }
  }

  // To-do No needed to use.
  Future<String> _getLinkCode() async {
    String linkCode;
    while (true) {
      linkCode = const Uuid().v4();
      final linkSnapshot = await db
          .collection(collectionPath)
          .where('invitation_link', isEqualTo: linkCode)
          .get();
      if (linkSnapshot.docs.isEmpty) {
        return linkCode;
      }
    }
  }

  // To-do No need to use linkCode params.
  DynamicLinkParameters _setDynamicLinkParams(String linkCode) {
    return DynamicLinkParameters(
      uriPrefix: 'https://logpose.page.link',
      link: Uri.parse('https://logpose.com/invite?code=$linkCode'),
      androidParameters: const AndroidParameters(
        packageName: 'com.logpose.app',
        minimumVersion: 1,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.example.logpose',
        minimumVersion: '1.0.0',
      ),
    );
  }

  Future<ShortDynamicLink> _buildInvitationLink(
    DynamicLinkParameters parameters,
  ) async {
    try {
      return await FirebaseDynamicLinks.instance.buildShortLink(
        parameters,
        shortLinkType: ShortDynamicLinkType.unguessable,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to build invitation link. ${e.message}');
    }
  }

  Timestamp _setExpireLimit() {
    return convertTimestampToTimestamp(
      DateTime.now().add(const Duration(days: 7)),
    );
  }

  @override
  Future<GroupInvitation> fetch(String docId) async {
    try {
      final data =
          (await db.collection(collectionPath).doc(docId).get()).data();
      if (data == null) {
        throw Exception('Error : No found document data.');
      }

      final model = GroupInvitationModel.fromMap(data);
      return GroupInvitationMapper.toEntity(model);
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
