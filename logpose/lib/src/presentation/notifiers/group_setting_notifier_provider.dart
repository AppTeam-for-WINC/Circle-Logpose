import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/group_profile.dart';

import '../../domain/usecase/facade/group_facade.dart';

final groupSettingNotifierProvider = StateNotifierProvider.family
    .autoDispose<_GroupSettingNotifier, GroupProfile?, String>(
  _GroupSettingNotifier.new,
);

class _GroupSettingNotifier extends StateNotifier<GroupProfile?> {
  _GroupSettingNotifier(this.ref, this.groupId)
      : groupFacade = ref.read(groupFacadeProvider),
        super(null) {
    _initGroupProfile();
  }

  final Ref ref;
  final String groupId;
  final GroupFacade groupFacade;

  Future<void> _initGroupProfile() async {
    try {
      state = await groupFacade.fetchGroup(groupId);
    } on Exception catch (e) {
      state = null;
      debugPrint('Error: No found group $e');
    }
  }

  Future<void> changeImage(File newImage) async {
    if (state != null) {
      state = state!.copyWith(image: newImage.path);
    }
  }
}
