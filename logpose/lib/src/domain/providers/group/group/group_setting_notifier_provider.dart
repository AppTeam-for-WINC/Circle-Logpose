import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repository/database/group_repository.dart';

import '../../../../models/database/group/group_profile.dart';

/// Group setting provider.
final groupSettingNotifierProvider = StateNotifierProvider.family
    .autoDispose<_GroupSettingNotifier, GroupProfile?, String>(
  (ref, groupId) => _GroupSettingNotifier(groupId),
);

/// Group notifier class.
class _GroupSettingNotifier extends StateNotifier<GroupProfile?> {
  _GroupSettingNotifier(this.groupId) : super(null) {
    _initGroupProfile();
  }
  String groupId;

  Future<void> _initGroupProfile() async {
    try {
      state = await _fetchGroupProfile();
    } on Exception catch (e) {
      state = null;
      debugPrint('Error: No found group $e');
    }
  }

  Future<GroupProfile> _fetchGroupProfile() async {
    final groupData = await GroupRepository.watch(groupId).first;
    if (groupData == null) {
      state = null;
    }
    return groupData!;
  }

  /// Change GroupProfile image.
  Future<void> changeImage(File newImage) async {
    if (state != null) {
      state = state!.copyWith(image: newImage.path);
    }
  }
}
