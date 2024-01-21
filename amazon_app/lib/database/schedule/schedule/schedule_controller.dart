import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'schedule.dart';


//関数の場合は、Map型になるので、動的（dynamic）の返り値となるが、クラスの場合、それぞれの変数に型をつけることができ、返り値を必要としないため、
//データベースから値を取得する際は、クラスの方が保守性が上がる。

class GroupScheduleController {
  const GroupScheduleController();
  
  static final db = FirebaseFirestore.instance;

  ///schedule path
  static const collectionPath = 'schedules';

  /// FirestoreのTimestampからDateTimeに変換
  static DateTime? convertTimestampToDateTime(dynamic timestamp) {
    return timestamp is Timestamp ? timestamp.toDate() : null;
  }

  ///Create schudule database.
  ///Return created schedule document ID.
  static Future<void> create(
    ///Named parameters
    {
      required String groupId,
      required String title,
      required String color,
      String? place,
      String? detail,
      required DateTime startAt,
      required DateTime endAt,
    }
  ) async {
    ///Create new document ID.
    final doc = db.collection(collectionPath).doc();

    ///Get created server time.
    final createdAt = FieldValue.serverTimestamp();

    await doc.set({
      'group_id': groupId,
      'title': title,
      'color': color,
      'place': place,
      'detail': detail,
      'start_at': startAt,
      'end_at': endAt,
      'created_at': createdAt,
    });
  }

  ///Get all schedule database.
  static Future<List<GroupSchedule>> readAll(String groupId) async {
    final QuerySnapshot schedules = await db.collection(collectionPath)
      .where('group_id',isEqualTo: groupId,).get();

    final schedulesRefs = schedules.docs.map((doc) {
      final schedulesRef = doc.data() as Map<String, dynamic>?;
      if (schedulesRef == null) {
        throw Exception('Error: No found document data.');
      }

      ///Checked type of database variable;
      final groupId = schedulesRef['group_id'] as String;

      final title = schedulesRef['title'] as String;
      final color = schedulesRef['color'] as String;
      final place = schedulesRef['place'] as String?;
      final detail = schedulesRef['detail'] as String?;
      final startAt = schedulesRef['start_at'] as DateTime;
      final endAt = schedulesRef['end_at'] as DateTime;
      final updatedAt = schedulesRef['updated_at'] as Timestamp?;
      final createdAt = schedulesRef['created_at'] as Timestamp;
      
      return GroupSchedule(
        groupId: groupId,
        title: title,
        color: color,
        place: place,
        detail: detail,
        startAt: startAt,
        endAt: endAt,
        updatedAt: updatedAt,
        createdAt: createdAt,
      );
    }).toList();

    return schedulesRefs;
  }

  //Get selected schedule database.
  static Future<GroupSchedule> read(String docId) async {
    final snapshot = await db.collection(collectionPath).doc(docId).get();
    final data = snapshot.data();
    if (data == null) {
      throw Exception('documentId not found.');
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
    if (startAt is! DateTime) {
      startAt = null;
      throw Exception('Error: start_at is not valid.');
    }

    var endAt = data['end_at'];
    if (endAt is! DateTime) {
      endAt = null;
      throw Exception('Error: start_at is not valid.');
    }

    final updatedAt = data['updated_at'] as Timestamp?;

    final createdAt = data['created_at'] as Timestamp;

    return GroupSchedule(
      groupId: groupId,
      title: title,
      place: place,
      color: color,
      detail: detail,
      startAt: startAt,
      endAt: endAt,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }

  ///Update scheule database.
  ///Group ID can't be changed.
  static Future<void> update({
    required String docId,
    required String groupId,
    required String title,
    required String? place,
    required Color color,
    required String? detail,
    required DateTime startAt,
    required DateTime endAt,
  }
  ) async {
    final updatedAt = FieldValue.serverTimestamp();
    final updateData = <String, dynamic>{
      'group_id': groupId,
      'title': title,
      'place': place,
      'color': color,
      'detail': detail,
      'start_at': startAt,
      'end_at': endAt,
      'updated_at': updatedAt,
    };

    await db.collection(collectionPath).doc(docId).update(updateData);
  }

  static Future<void> delete(String docId) async {
    await db.collection(collectionPath).doc(docId).delete();
  }
}
