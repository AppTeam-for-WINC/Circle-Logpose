import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/group/database/group_profile.dart';
import '../../../../services/database/group_controller.dart';

/// Group setting provider.
final groupSettingProvider = StateNotifierProvider.family
    .autoDispose<_GroupSettingNotifier, GroupProfile?, String>(
  (ref, groupId) => _GroupSettingNotifier(groupId),
);

/// Group notifier class.
class _GroupSettingNotifier extends StateNotifier<GroupProfile?> {
  _GroupSettingNotifier(this.groupId) : super(null) {
    _initGroupProfile();
  }
  TextEditingController groupNameController = TextEditingController();
  String groupId;

  Future<void> _initGroupProfile() async {
    if (groupId.isEmpty) {
      state = null;
    }
    try {
      final groupData = await GroupController.watch(groupId).first;
      if (groupData != null) {
        state = groupData;
        groupNameController.text = groupData.name;
      } else {
        state = null;
      }
    } on Exception catch (e) {
      state = null;
      throw Exception('Error: No found group $e');
    }
  }

  Future<void> changeImage(File newImage) async {
    if (state != null) {
      state = state!.copyWith(image: newImage.path);
    }
  }
}
