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
      throw Exception('Error: Failed to upload image file. ${e.message}');
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
      throw Exception('Error: Failed to upload image file. ${e.message}');
    }
  }

  /// Folder is 'groups' or 'users'.
  static Reference _setReference(
    String folder,
    String docId,
    String path,
  ) {
    try {
      return storage.child('images/$folder/$docId/$path');
    } on FirebaseStorage catch (e) {
      throw Exception('Error: failed to set image of reference. $e');
    }
  }

  static UploadTask _uploadFile(
    Reference imagesRef,
    File imageFile,
    SettableMetadata metadata,
  ) {
    try {
      return imagesRef.putFile(imageFile, metadata);
    } on FirebaseStorage catch (e) {
      throw Exception('Error: failed to set image of reference. $e');
    }
  }

  static Future<void> _whenComplete(UploadTask uploadFile) async {
    try {
      await uploadFile.whenComplete(() => null);
    } on FirebaseStorage catch (e) {
      throw Exception('Error: failed to set image of reference. $e');
    }
  }

  static Future<String> _getDownloadURL(Reference imageRef) async {
    try {
      return imageRef.getDownloadURL();
    } on FirebaseStorage catch (e) {
      throw Exception('Error: failed to set image of reference. $e');
    }
  }

  Future<String> downloadGroupDefaultImageToStorage() async {
    try {
      final gsReference = FirebaseStorage.instance.refFromURL(
        'gs://fir-15300.appspot.com/images/default/default_group_jpg.png',
      );
      return await gsReference.getDownloadURL();
    } on FirebaseException catch (e) {
      throw Exception('Error: Failed to upload image file. ${e.message}');
    }
  }

  Future<String> downloadUserDefaultImageToStorage() async {
    try {
      final gsReference = FirebaseStorage.instance.refFromURL(
        'gs://fir-15300.appspot.com/images/default/default_user.jpg',
      );
      return await gsReference.getDownloadURL();
    } on FirebaseException catch (e) {
      throw Exception('Error: Failed to upload image file. ${e.message}');
    }
  }
}
