import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod.dart';
import '/database/authentication.dart';
import 'schedule.dart';


//関数の場合は、Map型になるので、動的（dynamic）の返り値となるが、クラスの場合、それぞれの変数に型をつけることができ、返り値を必要としないため、
//データベースから値を取得する際は、クラスの方が保守性が上がる。
// //ODMを使用すればなんとかなるんじゃね？？？
// //まずは、freezedと使う。

class ScheduleController {
  static final db = FirebaseFirestore.instance;

  ///schedule path
  static const collectionPath = 'schedules';

  ///Create schudule database.
  ///Return created schedule document ID.
  static Future<void> create(
    ///Named parameters
    {
      required String groupId,
      required String title,
      required Color color,
      String? place,
      String? detail,
      required DateTime startAt,
      required DateTime endAt,
    }
  ) async {
    ///Create new document ID.
    final doc = db.collection(collectionPath).doc();

    ///Change Color from String of type.
    final colorToString = color.toString();

    ///Get created server time.
    final createdAt = FieldValue.serverTimestamp();

    ///Exchanged DateTime to Timestamp.
    final startTimestamp = Timestamp.fromDate(startAt);
    final endTimestamp = Timestamp.fromDate(endAt);

    await doc.set({
      'group_id': groupId,
      'title': title,
      'color': colorToString,
      'place': place,
      'detail': detail,
      'start_at': startTimestamp,
      'end_at': endTimestamp,
      'created_at': createdAt,
    });
  }

  ///Get all schedule database.
  Future<List<Schedule>> readAll(String groupId) async {
    final QuerySnapshot snapshot = await db.collection(collectionPath)
      .where(
        {
          'group_id',
        },
        isEqualTo: groupId,
      ).get();

    final schedules = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        throw Exception('Error: No found document data.');
      }

      ///Checked type of database variable;
      final groupId = data['group_id'] as String;
            
      // var groupId = data['group_id'];
      // if (groupId is! String) {
      //   groupId = groupId.toString();
      // }

      final documentId = doc.id;
      final title = data['title'] as String;
      final color = data['color'] as String;
      final place = data['place'] as String?;
      final detail = data['detail'] as String?;
      final startAt = data['start_at'] as Timestamp;
      final endAt = data['end_at'] as Timestamp;
      final createdAt = data['created_at'] as Timestamp;
      
      return Schedule(
        groupId: groupId,
        documentId: documentId,
        title: title,
        color: color,
        place: place,
        detail: detail,
        startAt: startAt,
        endAt: endAt,
        createdAt: createdAt,
      );
    }).toList();

    return schedules;
  }

  //Get selected schedule database.
  Future<Schedule> read(String documentId) async {
    final snapshot = await db.collection(collectionPath).doc(documentId).get();
    final data = snapshot.data();
    if (data == null) {
      throw Exception('documentId not founded.');
    }

    //型が正しいかどうかチェック。
    var groupId = data['group_id'];
    if (groupId is! String) {
      groupId = groupId.toString();
    }

    var title = data['title'];
    if (title is! String) {
      title = title.toString();
    }

    var place = data['place'];
    if (place is! String) {
      place = place.toString();
    }

    var color = data['color'];
    if (color is! String) {
      color = color.toString();
    }

    var detail = data['detail'];
    if (detail is! String) {
      detail = detail.toString();
    }

    var startAt = data['start_at'];
    if (startAt is! Timestamp) {
      startAt = null;
      throw Exception('Error: start_at is not exist.');
    }

    var endAt = data['end_at'];
    if (endAt is! Timestamp) {
      endAt = null;
      throw Exception('Error: end_at is not exist.');
    }

    var createdAt = data['created_at'];
    if (createdAt is! Timestamp) {
      createdAt = null;
      throw Exception('Error: created_at is not exist.');
    }

    return Schedule(
      groupId: groupId,
      title: title,
      place: place,
      color: color,
      detail: detail,
      startAt: startAt,
      endAt: endAt,
      createdAt: createdAt,
    );
  }

  ///Update scheule database.
  ///Group ID can't be changed.
  Future<void> update({
    required String groupId,
    required String documentId,
    String? title,
    String? place,
    Color? color,
    String? detail,
    DateTime? startAt,
    DateTime? endAt,
  }
  ) async {

    final updateData = <String, dynamic>{};

    if (title != null) {
      updateData['title'] = title;
    }

    if (place != null) {
      updateData['place'] = place;
    }

    if (color != null) {
      updateData['color'] = color.toString();
    }

    if (detail != null) {
      updateData['detail'] = detail;
    }

    if (startAt != null) {
      updateData['start_at'] = Timestamp.fromDate(startAt);
    }

    if (endAt != null) {
      updateData['end_at'] = Timestamp.fromDate(endAt);
    }

    await db.collection(collectionPath).doc(documentId).update(updateData);
  }

  ///Update all schedule database.
  Future<void> updateAll(String documentId) async {
    await db.collection(collectionPath).doc(documentId).update({
      //Update data.
    });
  }

  ///Delete all schedule database
  Future<void> deleteAll(String documentId) async {
    await db.collection(collectionPath).doc(documentId).delete();
  }

  ///Watch schedule database.
  Stream<void> watch() async* {

  }

  
}

//StreamProvider #######################



// class Sample extends ConsumerWidget{
//   const Sample({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final service = FirestoreService().create();
//     return Text('');
//   }
// }


///関数の説明　三本
// Future createSchedule(
//   String groupId,
//   String title,
//   String color,
//   String? place,
//   String? detail,
//   DateTime startAt,
//   DateTime endAt,
//   WidgetRef ref,
// ) async {
//   try {
//     //uuidを生成。
//     const uuid = Uuid();
//     final docId = (uuid.v4).toString();

//     //指定したコレクション（schedules データベース）を取得し、idを設定。
//     DocumentReference documentReference =
//         FirebaseFirestore.instance.collection('schedules').doc(docId);

//     //追加するデータを指定。
//     Map<String?, dynamic> addData = {
//       'group_id': groupId,
//       'title': title,
//       'color': color,
//       'place': place,
//       'detail': detail,
//       'start_at': startAt,
//       'end_at': endAt,
//     };

//     //データを追加。
//     await documentReference.set(addData);
//     FirebaseFirestore.instance.collection('schedules').add();
    
//     debugPrint('予定を作成しました。');
//   } catch (error) {
//     debugPrint('予定の作成に失敗しました。 $error');
//   }
// }


// Future <Map<String?, dynamic>> getSchedule(
//   String id,
//   WidgetRef ref,
// ) async {
//   try {
//     DocumentSnapshot scheduleInfo =
//         await FirebaseFirestore.instance.collection('schedules').doc(id).get();

//     String groupId = scheduleInfo['group_id'];
//     String title = scheduleInfo['title'];
//     Color color = scheduleInfo['color'];
//     String? place = scheduleInfo['place'];
//     String? detail = scheduleInfo['detail'];
//     String startAt = scheduleInfo['start_at'];
//     String endAt = scheduleInfo['end_at'];


//     DocumentSnapshot<Map<String, dynamic>> groupInfo = await getGroupInfo(groupId);

//     String groupName = groupInfo['name'];
//     String groupImage = groupInfo['image'];
    
//     debugPrint('予定の取得に成功しました。');
//     return {
//       'scheduleId': id, 
//       'groupId': groupId, 
//       'title': title, 
//       'color': color,
//       'place': place,
//       'detail': detail,
//       'startAt': startAt,
//       'endAt': endAt,
//       'groupName': groupName,
//       'groupImage': groupImage,
//     };
//   } catch (error) {
//     debugPrint('予定を取得することができませんでした。 $error');
//     return {'error': error};
//   }
// }


// Future createMemberCondition() async {

// }


// Future inputMemberCondition(
//   String id,
//   String scheduleId,
//   String userId,
//   bool attendance,
//   bool leaveEarly,
//   bool lateness,
//   bool absence,
//   DateTime? startAt,
//   DateTime? endAt,
//   WidgetRef ref,
// ) async {
//   try {
//     DocumentReference memberCondition =
//         FirebaseFirestore.instance.collection('membercondition').doc(id);

//     DocumentSnapshot getScheduleField =
//         await FirebaseFirestore.instance.collection('schedules').doc(scheduleId).get();

//     Map<>
//     await memberCondition.update(updateCondition);

//   } catch (error) {

//   }
// }


















// 以下はデータを追加する関数
// updateDocumentData(コレクション(user_info or group_info or Schedule_info),docId(user.uid or primaryGropuId),Map型のデータ)で成功したらtrueを返す。
// この関数を使う前にMap型のデータを定義する必要がある詳細は110行目あたりに書いてある。
Future<bool> updateDocumentData(String collectionName, String docId,
    Map<String, dynamic> updateData, WidgetRef ref,) async {
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
                      UserCredential userCredential =
                          await _auth.signInWithEmailAndPassword(
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
                      print(await updateDocumentData(
                          'user_info', user.uid, loginData, ref));

                      // 以下はデータを取得する作業まず、Map型のデータにgetDocumentData関数を使って定義する。()内については56行目あたりに書いてある。
                      // 次に、dynamic型にMap型で取得したデータのうち使うデータ(今回はuser_name)を指定し定義する。
                      Map<String, dynamic>? documentData =
                          await getDocumentData('user_info', user.uid, ref);
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
