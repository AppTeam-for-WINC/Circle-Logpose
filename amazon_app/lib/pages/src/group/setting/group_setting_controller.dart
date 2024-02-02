import 'dart:io';

import 'package:amazon_app/database/group/group/group.dart';
import 'package:amazon_app/database/group/group/group_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupSettingProvider =
    StateNotifierProvider.family<GroupSettingNotifier, GroupProfile?, String>(
  (ref, groupId) => GroupSettingNotifier(groupId),
);

class GroupSettingNotifier extends StateNotifier<GroupProfile?> {
  GroupSettingNotifier(this.groupId) : super(null) {
    initProfile();
  }
  TextEditingController groupNameController = TextEditingController();
  String groupId;
  GroupProfile? group;
  // String? image;

  Future<void> initProfile() async {
    if (groupId.isEmpty) {
      state = null;
      return;
    }
    try {
      group = await GroupController.read(groupId);
      if (group != null) {
        state = group;
        groupNameController.text = group!.name;
        // image = group!.image;
      } else {
        state = null;
      }
    } on Exception catch (e) {
      throw Exception('Error: No found group $e');
    }
  }

  Future<void> changeProfile(File newImage) async {
    if (state != null) {
      state = GroupProfile(
        name: state!.name,
        image: newImage.path,
        createdAt: state!.createdAt,
      );
    }
  }
}
