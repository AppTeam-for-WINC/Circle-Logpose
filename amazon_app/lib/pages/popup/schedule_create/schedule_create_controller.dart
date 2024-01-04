import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/database/group/group/group.dart';
import '/database/group/group/group_controller.dart';

final scheduleCreationDataProvider =
    Provider<ScheduleCreationData>(ScheduleCreationData.new);

class ScheduleCreationData {
  ScheduleCreationData(this.ref) {
    loadGroups();
  }

  final Ref ref;
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController titleController = TextEditingController();
  Color selectedColor = Colors.white;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController placeController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  List<Group>? groups;
  List<String>? groupNames;
  List<String?>? groupIds;
  List<String>? groupImages;
  String? selectedGroupId;
  String? selectedGroupName;

  //No need to debugPrint(apple); apple is too expensiver!!!
  Future<void> loadGroups() async {
    groups = await GroupController.readAll();
    groupNames = groups?.map((group) => group.name).toList();
    groupIds = groups?.map((group) => group.documentId).toList();
    groupImages = groups?.map((group) => group.image).toList();
    final apple = ref.refresh(scheduleCreationDataProvider);
    debugPrint(apple.toString());
  }
}
