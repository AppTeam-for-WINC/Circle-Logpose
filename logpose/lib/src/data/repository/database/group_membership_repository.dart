import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entity/group_membership.dart';
import '../../../domain/entity/user_profile.dart';

import '../../interface/i_group_membership_repository.dart';

import '../../mapper/group_membership_mapper.dart';

import '../../model/group_membership_model.dart';
import 'user_repository.dart';

final groupMembershipRepositoryProvider = Provider<IGroupMembershipRepository>(
  (ref) => GroupMembershipRepository(ref: ref),
);

class GroupMembershipRepository implements IGroupMembershipRepository {
  GroupMembershipRepository({required this.ref});

  final Ref ref;
  static final db = FirebaseFirestore.instance;
  static const collectionPath = 'group_memberships';

  @override
  Future<void> createMemmbership(
    String userDocId,
    String role,
    String groupId,
  ) async {
    try {
      final groupMembershipDoc = db.collection(collectionPath).doc();
      final data = (await db.collection('users').doc(userDocId).get()).data();
      if (data == null) {
        throw Exception('Error : No found document data.');
      }

      await groupMembershipDoc.set({
        'user_id': userDocId,
        'username': data['name'] as String,
        'user_description': data['description'] as String?,
        'group_id': groupId,
        'role': role,
        'created_at': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to create group membership database. ${e.message}',
      );
    }
  }

  @override
  Future<List<String>> fetchAllMembershipIdList(String groupId) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('group_id', isEqualTo: groupId)
          .get();

      return _fetchMembershipIdList(snapshot);
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to fetch all member ID list. ${e.message}',
      );
    }
  }

  @override
  Stream<List<String>> listenAllMembershipIdList(String groupId) async* {
    try {
      final stream = db
          .collection(collectionPath)
          .where('group_id', isEqualTo: groupId)
          .snapshots();

      await for (final snapshot in stream) {
        yield _fetchMembershipIdList(snapshot);
      }
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to listen user docId list. ${e.message}');
    }
  }

  static List<String> _fetchMembershipIdList(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    try {
      return snapshot.docs.map((doc) => doc.id).toList();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch membership ID. ${e.message}');
    }
  }

  @override
  Future<List<String>> fetchAllUserDocIdWithGroupId(String groupId) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('group_id', isEqualTo: groupId)
          .get();

      return _fetchuserDocIdList(snapshot);
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to fetch group member docId. ${e.message}',
      );
    }
  }

  @override
  Stream<List<String?>> watchAllUserDocIdWithGroupId(String groupId) async* {
    try {
      final stream = db
          .collection(collectionPath)
          .where('group_id', isEqualTo: groupId)
          .snapshots();

      await for (final snapshot in stream) {
        yield _fetchuserDocIdList(snapshot);
      }
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to listen user docId list. ${e.message}');
    }
  }

  static List<String> _fetchuserDocIdList(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs.map((doc) {
      final userDocId = doc.data()['user_id'] as String?;
      if (userDocId == null) {
        throw Exception('No found document data.');
      }
      return userDocId;
    }).toList();
  }

  /// Check member is Exist by groupId, userDocId.
  @override
  Future<bool> doesMemberExist({
    required String groupId,
    required String userDocId,
  }) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('group_id', isEqualTo: groupId)
          .where('user_id', isEqualTo: userDocId)
          .get();

      if (snapshot.docs.isEmpty) {
        return false;
      }

      return snapshot.docs.any((doc) {
        final data = doc.data() as Map<String, dynamic>?;
        return data != null;
      });
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to check member. ${e.message}');
    }
  }

  @override
  Stream<List<UserProfile?>> listenAllMember(
    String groupId,
  ) async* {
    try {
      final stream = db
          .collection(collectionPath)
          .where('group_id', isEqualTo: groupId)
          .snapshots();

      await for (final snapshot in stream) {
        yield await _fetchUserProfileList(snapshot: snapshot);
      }
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to watch user profile list. ${e.message}');
    }
  }

  /// Watch all role(Selected 'admin', or 'membership')
  /// member's profiles.
  @override
  Stream<List<UserProfile?>> listenAllUserProfileWithGroupIdAndRole(
    String groupId,
    String role,
  ) async* {
    try {
      final stream = db
          .collection(collectionPath)
          .where('group_id', isEqualTo: groupId)
          .where('role', isEqualTo: role)
          .snapshots();

      await for (final snapshot in stream) {
        yield await _fetchUserProfileList(snapshot: snapshot, role: role);
      }
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to watch user profile list. ${e.message}');
    }
  }

  Future<List<UserProfile?>> _fetchUserProfileList({
    required QuerySnapshot<Map<String, dynamic>> snapshot,
    String? role,
  }) async {
    return Future.wait(
      snapshot.docs.map((doc) async {
        final userDocId = doc.data()['user_id'] as String?;
        if (userDocId == null) {
          debugPrint('No found $role document data.');
          return null;
        }
        return _fetchUserProfile(userDocId);
      }).toList(),
    );
  }

  Future<UserProfile> _fetchUserProfile(String userId) async {
    final userRepository = ref.read(userRepositoryProvider);
    return userRepository.fetchUser(userId);
  }

  @override
  Stream<List<GroupMembership?>> listenAllMembershipListWithUserId(
    String userDocId,
  ) async* {
    try {
      final stream = db
          .collection(collectionPath)
          .where('user_id', isEqualTo: userDocId)
          .snapshots();

      await for (final snapshot in stream) {
        yield _fetchGroupMembershipList(snapshot);
      }
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to watch group member list. ${e.message}');
    }
  }

  static List<GroupMembership?> _fetchGroupMembershipList(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        debugPrint('Error : No found document data.');
        return null;
      }

      if (data['created_at'] == null) {
        return null;
      }

      final model = GroupMembershipModel.fromMap(data);
      return GroupMembershipMapper.toEntity(model);
    }).toList();
  }

  @override
  Future<GroupMembership> fetch(String docId) async {
    try {
      final memberDoc = await db.collection(collectionPath).doc(docId).get();
      final data = memberDoc.data();
      if (data == null) {
        throw Exception('Error : No found document data.');
      }
      final model = GroupMembershipModel.fromMap(data);
      return GroupMembershipMapper.toEntity(model);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group membership. ${e.message}');
    }
  }

  @override
  Future<String> fetchUserIdWithMembershipId(String docId) async {
    try {
      final memberDoc = await db.collection(collectionPath).doc(docId).get();
      final data = memberDoc.data();
      if (data == null) {
        throw Exception('Error : No found document data.');
      }

      return data['user_id'] as String;
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group membership. ${e.message}');
    }
  }

  @override
  Future<String> fetchMembershipIdWithGroupIdAndUserId(
    String groupId,
    String userId,
  ) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('group_id', isEqualTo: groupId)
          .where('user_id', isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.id;
      } else {
        throw Exception('No document found for the specified user and group.');
      }
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to watch user profile list. ${e.message}');
    }
  }

  @override
  Future<void> update({
    required String docId,
    required String userId,
    required String username,
    required String? userDescription,
    required String role,
    required String groupId,
  }) async {
    try {
      final updateData = <String, dynamic>{
        'user_id': userId,
        'username': username,
        'user_description': userDescription,
        'role': role,
        'group_id': groupId,
        'updated_at': FieldValue.serverTimestamp() as Timestamp,
      };
      await db.collection(collectionPath).doc(docId).update(updateData);
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to update group member database. ${e.message}',
      );
    }
  }

  @override
  Future<void> delete(String docId) async {
    try {
      await db.collection(collectionPath).doc(docId).delete();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete group member. ${e.message}');
    }
  }
}
