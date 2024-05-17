import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/group_profile.dart';

import '../../repository/group_repository_provider.dart';

final groupSettingNotifierProvider = StateNotifierProvider.family
    .autoDispose<_GroupSettingNotifier, GroupProfile?, String>(
  _GroupSettingNotifier.new,
);

class _GroupSettingNotifier extends StateNotifier<GroupProfile?> {
  _GroupSettingNotifier(this.ref, this.groupId) : super(null) {
    _initGroupProfile();
  }

  final Ref ref;
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
    final groupRepository = ref.read(groupRepositoryProvider);
    final groupData = await groupRepository.watch(groupId).first;

    if (groupData == null) {
      state = null;
    }
    return groupData!;
  }

  Future<void> changeImage(File newImage) async {
    if (state != null) {
      state = state!.copyWith(image: newImage.path);
    }
  }
}
