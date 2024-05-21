import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/group_facade.dart';

import '../../domain/entity/group_profile.dart';

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
    state = await groupFacade.fetchGroup(groupId);
  }

  Future<void> changeImage(File newImage) async {
    if (state != null) {
      state = state!.copyWith(image: newImage.path);
    }
  }
}
