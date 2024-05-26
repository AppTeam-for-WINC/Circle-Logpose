import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/components/group/joined_group_list/group_box/group_box.dart';

import '../providers/group/group/listen_joined_group_profile_provider.dart';

final groupProfileListNotifierProvider =
    StateNotifierProvider<_GroupProfileListNotifier, List<Widget>>(
  _GroupProfileListNotifier.new,
);

class _GroupProfileListNotifier extends StateNotifier<List<Widget>> {
  _GroupProfileListNotifier(this.ref) : super([]) {
    _groupProfileList();
  }

  final Ref ref;

  Future<void> _groupProfileList() async {
    final groupIdList = await ref.watch(listenJoinedGroupIdListProvider.future);
    state = _buildGroupBoxList(groupIdList);
  }

  List<Widget> _buildGroupBoxList(List<String> groupIdList) {
    return groupIdList.map((groupId) {
      return GroupBox(groupId: groupId);
    }).toList();
  }
}
