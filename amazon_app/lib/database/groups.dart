import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Groupschedule {
  static final db = FirebaseFirestore.instance;
  var uuid = Uuid();

  ///Create group database.
  ///Return created group document ID.
  Future<void> createGroup(

      ///Named parameters
      {
    required String groupId,
    required String name,
    String? image,
    required String membershipKey,
    required String adminKey,
  }) async {
    ///Create new groupid
    final doc = db.collection('groups').doc();

    ///Create new membershipkey
    membershipKey = uuid.v4();

    ///Create new adminkey
    adminKey = uuid.v4();

    ///get server time
    final createdAt = FieldValue.serverTimestamp();

    await doc.set({
      'group_id': groupId,
      'name': name,
      'image': image,
      'membership_key': membershipKey,
      'admin_key': adminKey,
    });
  }

  ///getting all group database
  Future<List<Group>> getAll({required String groupId}) async {
    final QuerySnapshot snapshot = await db.collection('group').where(
      {
        'group_id',
      },
      isEqualTo: groupId,
    ).get();

    final groups = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        throw Exception('Error : No found document data.');
      }
      final groupId = data['group_id'] as String;

      final name = data['name'] as String;
      final image = data['image'] as String?;
      final membershipKey = data['membership_key'] as String;
      final adminKey = data['admin_key'] as String;
      final createdAt = data['created_at'] as Timestamp;

      return Group(
        groupId: groupId,
        name: name,
        membershipKey: membershipKey,
        adminKey: adminKey,
        createdAt: createdAt,
      );
    }).toList();

    return groups;
  }

  ///getting voluntary group database
  Future<Group> get(String documentId) async {
    final snapshot = await db.collection('group').doc(documentId).get();
    final data = snapshot.data();
    if (data == null) {
      throw Exception('documentId not founded.');
    }

    var groupId = data['group_id'];
    if (groupId is! String) {
      groupId = groupId.toString();
    }

    var name = data['name'];
    if (name is! String) {
      name = name.toString();
    }

    var image = data['image'];
    if (image is! String) {
      image = image.toString();
    }

    var membershipKey = data['membership_key'];
    if (membershipKey is! String) {
      membershipKey = membershipKey.toString();
    }

    var adminKey = data['admin_key'];
    if (adminKey is! String) {
      adminKey = adminKey.toString();
    }

    var createdAt = data['created_at'];
    if (createdAt is! Timestamp) {
      createdAt = null;
      throw Exception('Error: create_at isn`t exist');
    }

    return Group(
        groupId: groupId,
        name: name,
        membershipKey: membershipKey,
        adminKey: adminKey,
        createdAt: createdAt,);

  }
}

//NICE !!
class Group {
  Group({
    required this.groupId,
    required this.name,
    this.image,
    required this.membershipKey,
    required this.adminKey,
    required this.createdAt,
  });

  ///group ID
  final String groupId;

  ///name
  final String name;

  ///image
  final String? image;

  ///memberkey
  final String membershipKey;

  ///adminKey
  final String adminKey;

  ///created time
  final Timestamp createdAt;
}
