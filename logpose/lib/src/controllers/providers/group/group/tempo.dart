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

/// Group of notifier.
class _GroupSettingNotifier extends StateNotifier<GroupProfile?> {
  _GroupSettingNotifier(this.groupId) : super(null) {
    _initGroupProfile();
  }
  TextEditingController groupNameController = TextEditingController();
  String groupId;
  GroupProfile? group;

  Future<void> _initGroupProfile() async {
    if (groupId.isEmpty) {
      state = null;
      return;
    }
    try {
      final groupStream = GroupController.watch(groupId);
      await for (final groupData in groupStream) {
        if (groupData == null) {
          continue;
        }
        group = groupData;
        if (group != null) {
          state = group;
          groupNameController.text = group!.name;
        } else {
          state = null;
        }
        return;
      }
    } on Exception catch (e) {
      throw Exception('Error: No found group $e');
    }
  }

  Future<void> changeImage(File newImage) async {
    if (state != null) {
      state = GroupProfile(
        name: state!.name,
        image: newImage.path,
        createdAt: state!.createdAt,
      );
    }
  }
}
