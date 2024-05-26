import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../exceptions/user/user_exception.dart';

import '../../../domain/entity/user_profile.dart';

import '../../../presentation/components/common/error_messages.dart';

import '../../interface/i_user_repository.dart';

import '../../mapper/user_profile_mapper.dart';

import '../../model/user_profile_model.dart';

import '../storage/storage_repository.dart';

final userRepositoryProvider = Provider<IUserRepository>(
  (ref) => UserRepository(ref: ref),
);

class UserRepository implements IUserRepository {
  UserRepository({required this.ref});

  final Ref ref;
  static final db = FirebaseFirestore.instance;
  static const uuid = Uuid();
  static const collectionPath = 'users';

  @override
  Future<void> createUser({
    required String docId,
    String? accountId,
    String? name,
    String? image,
    String? description,
  }) async {
    try {
      while (true) {
        final snapshot = await db
            .collection(collectionPath)
            .where('account_id', isEqualTo: accountId)
            .get();
        accountId = uuid.v4();
        if (snapshot.docs.isEmpty) {
          break;
        }
      }

      String? imagePath;
      if (image == '') {
        imagePath = await _downloadUserDefaultImageToStorage();
      } else if (image != null) {
        imagePath = await _uploadUserImageToStorage(docId, image);
      } else {
        throw Exception('Error: failed to set user data.');
      }

      await db.collection(collectionPath).doc(docId).set({
        'account_id': accountId,
        'name': name,
        'image': imagePath,
        'description': description,
        'created_at': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create user account. ${e.message}');
    }
  }

  Future<String> _downloadUserDefaultImageToStorage() async {
    final storageRepository = ref.read(storageRepositoryProvider);
    return storageRepository.downloadUserDefaultImageToStorage();
  }

  Future<String> _uploadUserImageToStorage(
    String userDocId,
    String image,
  ) async {
    final storageRepository = ref.read(storageRepositoryProvider);
    return storageRepository.uploadUserImageToStorage(userDocId, image);
  }

  @override
  Future<UserProfile> fetchUser(String docId) async {
    try {
      final data =
          (await db.collection(collectionPath).doc(docId).get()).data();
      if (data == null) {
        throw RepositoryException(DBErrorMessages.userNotFound + docId);
      }

      final model = UserProfileModel.fromMap(data);

      return UserProfileMapper.toEntity(model);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user profile. ${e.message}');
    }
  }

  @override
  Stream<UserProfile?> listenUser(String docId) {
    try {
      return db
          .collection(collectionPath)
          .doc(docId)
          .snapshots()
          .map((snapshot) {
        final data = snapshot.data();
        if (data == null) {
          debugPrint('Error : No found document data.');
          return null;
        }

        final model = UserProfileModel.fromMap(data);

        return UserProfileMapper.toEntity(model);
      });
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user profile. ${e.message}');
    }
  }

  @override
  Future<UserProfile?> fetchUserProfileWithAccountId(String accountId) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('account_id', isEqualTo: accountId)
          .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }

      return _fetchUserProfile(snapshot);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch accountId. ${e.message}');
    }
  }

  static UserProfile? _fetchUserProfile(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs
        .map((doc) {
          final data = doc.data() as Map<String, dynamic>?;
          if (data == null) {
            return null;
          }

          final model = UserProfileModel.fromMap(data);

          return UserProfileMapper.toEntity(model);
        })
        .whereType<UserProfile>()
        .firstOrNull;
  }

  @override
  Future<String> fetchUserDocIdWithAccountId(String accountId) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('account_id', isEqualTo: accountId)
          .get();

      if (snapshot.docs.isEmpty) {
        throw RepositoryException(
          DBErrorMessages.userAccountNotFound + accountId,
        );
      }
      final data = snapshot.docs.first.data() as Map<String, dynamic>?;
      if (data == null) {
        throw RepositoryException(DBErrorMessages.noDocumentData);
      }

      return snapshot.docs.first.id;
    } on FirebaseException catch (e) {
      throw UserException('Error: failed to fetch user ID. ${e.message}');
    }
  }

  @override
  Future<void> updateUser(
    String docId,
    String? name,
    String? image,
    String? description,
  ) async {
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
            await storageRepository.uploadUserImageToStorage(docId, image!);
      }
      if (description != null) {
        updateData['description'] = description;
      }

      await db.collection(collectionPath).doc(docId).update(updateData);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update user profile. ${e.message}');
    }
  }

  @override
  Future<bool> updateAccountId(String docId, String accountId) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('account_id', isEqualTo: accountId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        debugPrint('The account ID is already used');
        return false;
      }

      final updateData = <String, String>{
        'account_id': accountId,
      };

      await db.collection(collectionPath).doc(docId).update(updateData);
      return true;
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update accountId. ${e.message}');
    }
  }

  /// To-do update.
  /// テーブルはこの関数で削除できるが、authenticationには反映されない。
  Future<void> delete(String docId) async {
    try {
      await db.collection(collectionPath).doc(docId).delete();
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to delete user profile table. ${e.message}',
      );
    }
  }
}
