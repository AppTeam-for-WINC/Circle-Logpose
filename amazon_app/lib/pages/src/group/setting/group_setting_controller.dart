import 'dart:io';

import 'package:amazon_app/database/group/group/group.dart';
import 'package:amazon_app/database/group/group/group_controller.dart';
import 'package:amazon_app/database/group/schedule/schedule/schedule.dart';
import 'package:amazon_app/database/group/schedule/schedule/schedule_controller.dart';
import 'package:amazon_app/validation/validation.dart';
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

/// Update group settings.
class UpdateGroupSettings {
  UpdateGroupSettings._internal();
  static final UpdateGroupSettings _instance = UpdateGroupSettings._internal();
  static UpdateGroupSettings get instance => _instance;

  static Future<bool> update(
    String groupId,
    String name,
    String? description,
    File? image,
  ) async {
    String? imagePath;
    final nameValidation = GroupValidation.nameValidation(name);
    if (!nameValidation) {
      debugPrint('Failed to updated profile');
      return false;
    }
    if (image == null) {
      imagePath = null;
    } else {
      imagePath = image.path;
    }

    await GroupController.update(
      docId: groupId,
      name: name,
      description: description,
      image: imagePath,
    );

    debugPrint('Success: Changed profile.');
    return true;
  }
}

class GroupValidation {
  GroupValidation._internal();
  static final GroupValidation _instance = GroupValidation._internal();
  static GroupValidation get instance => _instance;

  static bool nameValidation(String name) {
    const requiredValidation = RequiredValidation();
    const maxLength32Validation = MaxLength32Validation();

    final nameRequiredValidation = requiredValidation.validate(
      name,
      'name',
    );
    final nameMaxLength32Validation = maxLength32Validation.validate(
      name,
      'name',
    );
    if (!nameRequiredValidation) {
      final errorMessage =
          const RequiredValidation().getStringInvalidRequiredMessage();

      debugPrint('nameError: $errorMessage');
      return false;
    }
    if (!nameMaxLength32Validation) {
      final errorMessage =
          const MaxLength32Validation().getMaxLengthInvalidMessage();

      debugPrint('nameError: $errorMessage');
      return false;
    }

    return true;
  }
}

final readGroupScheduleProvider =
    StreamProvider.family<List<GroupSchedule>, String>(
  (ref, groupId) async* {
    final schedulesStream = GroupScheduleController.readAll(groupId);

    await for (final schedules in schedulesStream) {
      final scheduleList = await Future.wait(
        schedules.map((schedule) async {
          if (schedule == null) {
            return null;
          }
          return schedule;
        }),
      );
      yield scheduleList.whereType<GroupSchedule>().toList();
    }
  },
);
