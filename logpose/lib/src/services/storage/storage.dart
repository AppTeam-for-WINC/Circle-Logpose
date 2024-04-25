import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class StorageController {
  const StorageController();
  static final storage = FirebaseStorage.instance.ref();

  static Future<String?> uploadUserImageToStorage(
    String userId,
    String image,
  ) async {
    try {
      final metadata = SettableMetadata(contentType: 'image/*');
      final imageFile = File(image);
      final imageRef = _setReference(userId, imageFile.path);
      final uploadFile = _uploadFile(imageRef, imageFile, metadata);
      await _whenComplete(uploadFile);

      return await _getDownloadURL(imageRef);
    } on FirebaseException catch (e) {
      debugPrint('Error: Failed to upload image file. $e');
      return null;
    }
  }

  static Future<String?> uploadGroupImageToStorage(
    String groupId,
    String image,
  ) async {
    try {
      final metadata = SettableMetadata(contentType: 'image/*');
      final imageFile = File(image);
      final imageRef = _setReference(groupId, imageFile.path);
      final uploadFile = _uploadFile(imageRef, imageFile, metadata);
      await _whenComplete(uploadFile);

      return await _getDownloadURL(imageRef);
    } on FirebaseException catch (e) {
      debugPrint('Error: Failed to upload image file. $e');
      return null;
    }
  }

  static Reference _setReference(String userId, String path) {
    return storage.child('images/users/$userId/$path');
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
}
