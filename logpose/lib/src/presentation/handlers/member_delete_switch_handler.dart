import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../navigations/modals/to_member_list_delete_navigator.dart';

import '../providers/group/mode/group_member_delete_mode_provider.dart';

class MemberDeleteSwitchHandler {
  MemberDeleteSwitchHandler({
    required this.context,
    required this.ref,
    this.groupId,
  });

  final BuildContext context;
  final WidgetRef ref;
  final String? groupId;

  Future<void> handleDeleteSwitchOfCreation() async {
    _switch();
  }

  Future<void> handleDeleteSwitchOfSetting() async {
    _switchToTrue();
    await _showModal();
  }

  void _switch() {
    ref.watch(groupMemberDeleteModeProvider.notifier).state =
        !ref.read(groupMemberDeleteModeProvider);
  }

  void _switchToTrue() {
    ref.watch(groupMemberDeleteModeProvider.notifier).state = true;
  }

  Future<void> _showModal() async {
    final navigator = ToMemberListDeleteNavigator(context);
    await navigator.showModal(groupId!);
  }
}
