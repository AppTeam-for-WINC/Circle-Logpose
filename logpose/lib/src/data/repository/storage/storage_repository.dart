import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageRepositoryProvider = Provider<StorageRepository>(
  (ref) => const StorageRepository(),
);

class StorageRepository {
  const StorageRepository();
  static final storage = FirebaseStorage.instance.ref();

  Future<String> uploadUserImageToStorage(
    String userId,
    String image,
  ) async {
    try {
      final metadata = SettableMetadata(contentType: 'image/*');
      final imageFile = File(image);
      final imageRef = _setReference('users', userId, imageFile.path);
      final uploadFile = _uploadFile(imageRef, imageFile, metadata);
      await _whenComplete(uploadFile);

      return await _getDownloadURL(imageRef);
    } on FirebaseException catch (e) {
      throw Exception('Error: Failed to upload image file. $e');
    }
  }

  Future<String> uploadGroupImageToStorage(
    String groupId,
    String image,
  ) async {
    try {
      final metadata = SettableMetadata(contentType: 'image/*');
      final imageFile = File(image);
      final imageRef = _setReference('groups', groupId, imageFile.path);
      final uploadFile = _uploadFile(imageRef, imageFile, metadata);
      await _whenComplete(uploadFile);

      return await _getDownloadURL(imageRef);
    } on FirebaseException catch (e) {
      throw Exception('Error: Failed to upload image file. $e');
    }
  }

  /// Folder is 'groups' or 'users'.
  static Reference _setReference(
    String folder,
    String docId,
    String path,
  ) {
    return storage.child('images/$folder/$docId/$path');
  }

  static UploadTask _uploadFile(
    Reference imagesRef,
    File imageFile,
    SettableMetadata metadata,
  ) {
    return imagesRef.putFile(imageFile, metadata);
  }

  static Future<void> _whenComplete(UploadTask uploadFile) async {
    await uploadFile.whenComplete(() => null);
  }

  static Future<String> _getDownloadURL(Reference imageRef) async {
    return imageRef.getDownloadURL();
  }

  Future<String> downloadGroupDefaultImageToStorage() async {
    try {
      final gsReference = FirebaseStorage.instance.refFromURL(
        'gs://fir-15300.appspot.com/images/default/default_group_jpg.png',
      );
      return await gsReference.getDownloadURL();
    } on FirebaseException catch (e) {
      throw Exception('Error: Failed to upload image file. $e');
    }
  }

  Future<String> downloadUserDefaultImageToStorage() async {
    try {
      final gsReference = FirebaseStorage.instance.refFromURL(
        'gs://fir-15300.appspot.com/images/default/default_user.jpg',
      );
      return await gsReference.getDownloadURL();
    } on FirebaseException catch (e) {
      throw Exception('Error: Failed to upload image file. $e');
    }
  }
}
