import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//logindata update
//logindata
//create Sign up

// 下記updateLoginData関数を使えばデータベースの更新ができます
Future<bool> updateLoginData(String primaryId, String foreignKey,
    String userName, String mailAddress, String password) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('login');
    DocumentReference userDoc = users.doc(primaryId);

    Map<String, dynamic> updateData = {
      'user_name': userName,
      'mail_address': mailAddress,
      'password': password,
      'foreign_key': foreignKey,
    };

    await userDoc.update(updateData);
    print('データのアップデート成功しました');
    return true;
  } catch (error) {
    print('データのアップデート中にエラーが発生しました: $error');
    return false;
  }
}

// 下記getLogInData関数を使えばデータベースから取得できます。
Future<bool> getLoginData() async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('login');
    DocumentReference userDoc = users.doc('primary_id');

    DocumentSnapshot document = await userDoc.get();

    if (document.exists) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      print('データの取得に成功しました: $data');
      return true;
    } else {
      print('ドキュメントが存在しません。');
      return false;
    }
  } catch (error) {
    print('データの取得中にエラーが発生しました: $error');
    return false;
  }
}

// 下記updateSignUpData関数を使えばデータベースの更新ができます
Future<bool> updateSignUpData(String primaryId, String foreignKey,
    String userName, String mailAddress, String password) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('sign_up');
    DocumentReference userDoc = users.doc(primaryId);

    Map<String, dynamic> updateData = {
      'user_name': userName,
      'mail_address': mailAddress,
      'password': password,
      'foreign_key': foreignKey,
    };

    await userDoc.update(updateData);
    print('データのアップデート成功しました');
    return true; // Data updated successfully
  } catch (error) {
    print('データのアップデート中にエラーが発生しました: $error');
    return false; // Error occurred during data update
  }
}

// 下記getSignUpData関数を使えばデータベースから取得できます。
Future<bool> getSignUpData() async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('sign_up');
    DocumentReference userDoc = users.doc('primary_id');

    DocumentSnapshot document = await userDoc.get();

    if (document.exists) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      print('データの取得に成功しました: $data');
      return true;
    } else {
      print('ドキュメントが存在しません。');
      return false;
    }
  } catch (error) {
    print('データの取得中にエラーが発生しました: $error');
    return false;
  }
}

// 下記updateScheduleData関数を使えばスケジュールのデータを作成できる
Future<bool> updateScheduleInfoData(
  String primaryId,
  String ScheduleTitle,
  String ScheduleColor,
  String ScheduleStartDay,
  String ScheduleEndDay,
  String SchedulePlace,
  String ScheduleContent,
  String ScheduleMember,
) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('schedule_info');
    DocumentReference userDoc = users.doc(primaryId);

    Map<String, dynamic> updateData = {
      "schedule_title": ScheduleTitle,
      "schedule_color": ScheduleColor,
      "schedule_startday": ScheduleStartDay,
      "schedule_endday": ScheduleEndDay,
      "schedule_place": SchedulePlace,
      "schedule_content": ScheduleContent,
      "schedule_member": ScheduleMember,
    };

    await userDoc.update(updateData);
    print('データのアップデート成功しました');
    return true; // Data updated successfully
  } catch (error) {
    print('データのアップデート中にエラーが発生しました: $error');
    return false; // Error occurred during data update
  }
}

// 下記getScheduleData関数を使えばスケジュールのデータを取得できる
Future<bool> getScheduleInfoData() async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('schedule_info');
    DocumentReference userDoc = users.doc('primary_id');

    DocumentSnapshot document = await userDoc.get();

    if (document.exists) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      print('データの取得に成功しました: $data');
      return true;
    } else {
      print('ドキュメントが存在しません。');
      return false;
    }
  } catch (error) {
    print('データの取得中にエラーが発生しました: $error');
    return false;
  }
}

// 下記updateGroupInfoData関数を使えばデータベースの更新ができます
Future<bool> updateGroupInfoData(String primaryID, String groupName,
    String groupId, String groupImage, bool accessKey, bool editKey) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('group_info');
    DocumentReference userDoc = users.doc(primaryID);

    Map<String, dynamic> updateData = {
      'group_name': groupName,
      'group_id': groupId,
      'group_image': groupImage,
      'access_key': accessKey,
      'edit_key': editKey,
    };

    await userDoc.update(updateData);
    print('データのアップデート成功しました');
    return true;
  } catch (error) {
    print('データのアップデート中にエラーが発生しました: $error');
    return false;
  }
}

// 下記getGroupInfoData関数を使えばデータベースから取得できます。
Future<bool> getGroupInfoData() async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('group_info');
    DocumentReference userDoc = users.doc('primary_id');

    DocumentSnapshot document = await userDoc.get();

    if (document.exists) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      print('データの取得に成功しました: $data');
      return true;
    } else {
      print('ドキュメントが存在しません。');
      return false;
    }
  } catch (error) {
    print('データの取得中にエラーが発生しました: $error');
    return false;
  }
}

Future<bool> updateUserInfoData(
  String primaryId,
  String foreignKey,
  String userName,
  String mailAddress,
  String password,
  String userImage,
  String accessKey,
  String editKey,
) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('user_info');
    DocumentReference userDoc = users.doc(primaryId);

    Map<String, dynamic> updateData = {
      'primary_id': primaryId,
      'user_name': userName,
      'mail_address': mailAddress,
      'password': password,
      'foreign_key': foreignKey,
      'user_image': userImage,
      'access_key': accessKey,
      'edit_key': editKey,
    };

    await userDoc.update(updateData);
    print('データのアップデート成功しました');
    return true; // Data updated successfully
  } catch (error) {
    print('データのアップデート中にエラーが発生しました: $error');
    return false; // Error occurred during data update
  }
}

Future<bool> getUserInfoData() async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('user_info');
    DocumentReference userDoc = users.doc('primary_id');

    DocumentSnapshot document = await userDoc.get();

    if (document.exists) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      print('データの取得に成功しました: $data');
      return true;
    } else {
      print('ドキュメントが存在しません。');
      return false;
    }
  } catch (error) {
    print('データの取得中にエラーが発生しました: $error');
    return false;
  }
}

class DatabasePage extends ConsumerWidget {
  const DatabasePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          //タイトル
          middle: Text('StartPage Title'),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              updateSignUpData('primary_id', '', 'test', 'test', 'test');
              getSignUpData(); // データを更新する関数を呼び出す
              updateLoginData('primary_id', '', 'test', 'test', 'test');
              getLoginData(); // データを更新する関数を呼び出す
              updateScheduleInfoData('primary_id', 'test', 'test', 'test',
                  'test', 'test', 'test', 'test');
              getScheduleInfoData();
              updateGroupInfoData(
                "primary_id",
                "test",
                "test",
                "test",
                true,
                true,
              );
              updateUserInfoData(
                  "primary_id",
                  "foreignKey",
                  "userName",
                  "mailAddress",
                  "password",
                  "userImage",
                  "accessKey",
                  "editKey");
              getUserInfoData();
            },
            child: Text('StartPage'),
          ),
        ),
      ),
    );
  }
}
