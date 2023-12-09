import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'riverpod.dart';

Future<bool> createAccount(String mailAddress, String password) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.createUserWithEmailAndPassword(
      email: mailAddress,
      password: password,
    );
    print('アカウントの作成に成功しました');
    return true;
  } catch (error) {
    print('アカウントの作成中にエラーが発生しました: $error');
    return false;
  }
}

Future<bool> loginUser(String email, String password) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print('ログイン成功');
    return true;
  } catch (error) {
    print('ログイン中にエラーが発生しました: $error');
    return false;
  }
}

// 以下はデータを取得する関数
// getDocumentData(コレクション(user_info or group_info or Schedule_info),docId(user.uid or primaryGropuId))でMap型のデータを取得できる。
// user.uidは登録したユーザーの固有のID
Future<Map<String, dynamic>?> getDocumentData(
    String collectionName, String docId, WidgetRef ref) async {
      final firestore = ref.watch(firestoreProvider);
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference userDoc =
          firestore.collection(collectionName).doc(docId);
      DocumentSnapshot document = await userDoc.get();

      if (document.exists) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        print('データの取得に成功しました: $data');
        return data;
      } else {
        print('ドキュメントが存在しません。');
        return null;
      }
    } else {
      print('ユーザーがログインしていません。');
      return null;
    }
  } catch (error) {
    print('データの取得中にエラーが発生しました: $error');
    return null;
  }
}
