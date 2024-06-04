import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/group_profile.dart';

import '../controllers/group/group_management_controller.dart';

final groupSettingNotifierProvider = StateNotifierProvider.family
    .autoDispose<_GroupSettingNotifier, GroupProfile?, String>(
  _GroupSettingNotifier.new,
);

class _GroupSettingNotifier extends StateNotifier<GroupProfile?> {
  _GroupSettingNotifier(this.ref, this.groupId)
      : _groupController = ref.read(groupManagementControllerProvider),
        super(null) {
    _initGroupProfile();
  }

  final Ref ref;
  final String groupId;
  final GroupManagementController _groupController;

  Future<void> _initGroupProfile() async {
    state = await _groupController.fetchGroup(groupId);
  }

  Future<void> changeImage(File newImage) async {
    if (state != null) {
      state = state!.copyWith(image: newImage.path);
    }
  }
}
