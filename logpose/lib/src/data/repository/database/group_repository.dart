import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../exceptions/group/group_setting_exception.dart';

import '../../../domain/entity/group_profile.dart';

import '../../../domain/interface/i_group_repository.dart';

import '../../mapper/group_profile_mapper.dart';

import '../../model/group_profile_model.dart';

import '../storage/storage_repository.dart';

final groupRepositoryProvider = Provider<IGroupRepository>(
  (ref) => GroupRepository(ref: ref),
);

class GroupRepository implements IGroupRepository {
  GroupRepository({required this.ref});

  final Ref ref;
  static final db = FirebaseFirestore.instance;
  static const collectionPath = 'groups';

  @override
  Future<String> create(
    String name,
    String? image,
    String? description,
  ) async {
    try {
      final groupDoc = db.collection(collectionPath).doc();
      String? imagePath;

      if (image == '') {
        imagePath = await _downloadGroupDefaultImageToStorage();
      } else if (image != null) {
        imagePath = await _uploadGroupImageToStorage(groupDoc.id, image);
      } else {
        throw Exception('Error: failed to set group data.');
      }

      /// ここで createdAt変数に敢えて格納することで、serverTimestampの取得処理時間を獲得できる。
      final createdAt = FieldValue.serverTimestamp();

      await groupDoc.set({
        'name': name,
        'image': imagePath,
        'description': description,
        'updated_at': null,
        'created_at': createdAt,
      });

      return groupDoc.id;
    } on FirebaseException catch (e) {
      throw Exception('Failed to create group document: ${e.message}');
    }
  }

  Future<String> _downloadGroupDefaultImageToStorage() async {
    final storageRepository = ref.read(storageRepositoryProvider);
    return storageRepository.downloadGroupDefaultImageToStorage();
  }

  Future<String> _uploadGroupImageToStorage(
    String groupDocId,
    String image,
  ) async {
    final storageRepository = ref.read(storageRepositoryProvider);
    return storageRepository.uploadGroupImageToStorage(
      groupDocId,
      image,
    );
  }

  @override
  Future<List<String>> fetchAllGroupId(String userId) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('user_id', isEqualTo: userId)
          .get();

      return snapshot.docs.map((doc) => doc.id).toList();
    } on FirebaseException catch (e) {
      throw Exception('Failed to fetch Group ID list. ${e.message}');
    }
  }

  @override
  Stream<GroupProfile?> watch(String docId) {
    return db.collection(collectionPath).doc(docId).snapshots().map((snapshot) {
      final data = snapshot.data();
      if (data == null) {
        return null;
      }

      final model = GroupProfileModel.fromMap(data);

      return GroupProfileMapper.toEntity(model);
    });
  }

  @override
  Future<GroupProfile> fetchGroup(String docId) async {
    try {
      final snapshot = await db.collection(collectionPath).doc(docId).get();
      final data = snapshot.data();

      if (data == null) {
        throw Exception('Error: No data found for document ID $docId');
      }

      final model = GroupProfileModel.fromMap(data);

      return GroupProfileMapper.toEntity(model);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch Group. ${e.message}');
    }
  }

  @override
  Future<void> update({
    required String docId,
    required String? name,
    required String? description,
    required String? image,
  }) async {
    try {
      final updateData = <String, dynamic>{
        'updated_at': FieldValue.serverTimestamp(),
      };

      if (name != null) {
        updateData['name'] = name;
      }

      if (image != '') {
        final storageRepository = ref.read(storageRepositoryProvider);
        updateData['image'] =
            await storageRepository.uploadGroupImageToStorage(docId, image!);
      }

      if (description != null) {
        updateData['description'] = description;
      }

      await db.collection(collectionPath).doc(docId).update(updateData);
    } on FirebaseException catch (e) {
      throw GroupUpdateException('Error: failed to update group. ${e.message}');
    }
  }

  @override
  Future<void> delete(String docId) async {
    try {
      await db.collection(collectionPath).doc(docId).delete();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete group. ${e.message}');
    }
  }
}
