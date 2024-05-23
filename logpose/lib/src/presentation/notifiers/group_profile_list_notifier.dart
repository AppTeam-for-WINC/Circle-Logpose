import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/group/group/listen_joined_group_profile_provider.dart';
import '../components/components/group/joined_group_list/group_box/group_box.dart';

final groupProfileListNotifierProvider =
    StateNotifierProvider<GroupProfileListNotifier, List<Widget>>(
  GroupProfileListNotifier.new,
);

class GroupProfileListNotifier extends StateNotifier<List<Widget>> {
  GroupProfileListNotifier(this.ref) : super([]) {
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
