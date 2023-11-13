import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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


FirebaseFirestore firestore = FirebaseFirestore.instance;

// 以下はデータを取得する関数
// getDocumentData(コレクション(user_info or group_info or Schedule_info),docId(user.uid or primaryGropuId))でMap型のデータを取得できる。
// user.uidは登録したユーザーの固有のID
Future<Map<String, dynamic>?> getDocumentData(
    String collectionName, String docId) async {
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

// 以下はデータを追加する関数
// updateDocumentData(コレクション(user_info or group_info or Schedule_info),docId(user.uid or primaryGropuId),Map型のデータ)で成功したらtrueを返す。
// この関数を使う前にMap型のデータを定義する必要がある詳細は110行目あたりに書いてある。
Future<bool> updateDocumentData(String collectionName, String docId,
    Map<String, dynamic> updateData) async {
  try {

    // 現在ログイン中のユーザー情報を取得しログイン済みであったらcollectionNameのdocIdのfieldにupdateDataを追加する作業
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference userDoc =
          firestore.collection(collectionName).doc(docId);
      await userDoc.set(updateData, SetOptions(merge: true));
      print('データのアップデート成功しました');
      return true;
    } else {
      print('ユーザーがサインインしていません');
      return false;
    }
  } catch (error) {
    print('データのアップデート中にエラーが発生しました: $error');
    return false;
  }
}

class DatabasesPage extends ConsumerWidget {
  const DatabasesPage({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Firebase 操作ページ'),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CupertinoButton.filled(
                onPressed: () async {
                  try {
                    User? user = _auth.currentUser;

                    if (user == null) {
                      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                        email: 'sample@gmail.com',
                        password: 'aiueo12345',
                      );
                      print('userInfo: ${userCredential.user}');
                      user = userCredential.user;
                    }

                    if (user != null) {

                      // 以下はデータを追加する作業まず、Map型のデータ(今回はloginData)を定義する。
                      // 次に、updataDocumentData関数を使いデータをfirestoreに追加する。()内については56行目あたりに書いてある。
                      Map<String, dynamic> loginData = {"user_name": "test"};
                      print(await updateDocumentData('user_info', user.uid, loginData));

                      // 以下はデータを取得する作業まず、Map型のデータにgetDocumentData関数を使って定義する。()内については56行目あたりに書いてある。
                      // 次に、dynamic型にMap型で取得したデータのうち使うデータ(今回はuser_name)を指定し定義する。
                      Map<String, dynamic>? documentData = await getDocumentData('user_info', user.uid);
                      dynamic user_name = documentData!['user_name'];
                      print(user_name);
                    } else {
                      print('ユーザーは認証されていません。');
                    }
                  } catch (e) {
                    print('サインインでエラーが発生しました: $e');
                  }
                },
                child: Text('アカウント情報表示'),
              ),
              SizedBox(height: 20),
              CupertinoButton(
                onPressed: () {
                  createAccount("sample@gmail.com", "aiueo12345");
                },
                child: Text('アカウント作成'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
