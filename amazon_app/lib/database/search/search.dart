import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class SearchFromFirestore {
  const SearchFromFirestore();
  static final db = FirebaseFirestore.instance;

  static Future<List<Map<String, dynamic>>?> searchUser(String userId) async {
    const collectionPath = 'users';
    final snapshot = await db
        .collection(collectionPath)
        .where('userId', isEqualTo: userId)
        .get();
    
    if (snapshot.docs.isEmpty) {
      debugPrint("The user isn't exist.");
      return null;
    }
    final userProfile = snapshot.docs.map((doc) => doc.data()).toList();

    return userProfile;
  }
}
