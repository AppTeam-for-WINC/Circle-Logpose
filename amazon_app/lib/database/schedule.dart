import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:amazon_app/database/authentication.dart';
import 'riverpod.dart';



Future createSchedule() async{

}

Future getSchedule() async{

}

Future inputAttendance() async {
    
}























// 以下はデータを追加する関数
// updateDocumentData(コレクション(user_info or group_info or Schedule_info),docId(user.uid or primaryGropuId),Map型のデータ)で成功したらtrueを返す。
// この関数を使う前にMap型のデータを定義する必要がある詳細は110行目あたりに書いてある。
Future<bool> updateDocumentData(String collectionName, String docId,
    Map<String, dynamic> updateData, WidgetRef ref) async {
        final firestore = ref.watch(firestoreProvider);
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
                      print(await updateDocumentData('user_info', user.uid, loginData, ref));

                      // 以下はデータを取得する作業まず、Map型のデータにgetDocumentData関数を使って定義する。()内については56行目あたりに書いてある。
                      // 次に、dynamic型にMap型で取得したデータのうち使うデータ(今回はuser_name)を指定し定義する。
                      Map<String, dynamic>? documentData = await getDocumentData('user_info', user.uid, ref);
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
