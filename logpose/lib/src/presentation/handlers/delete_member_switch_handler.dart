import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/group/mode/group_member_delete_mode_provider.dart';

import '../navigations/modals/delete_member_switch_modal_navigator.dart';

class DeleteMemberSwitchHandler {
  DeleteMemberSwitchHandler({
    required this.context,
    required this.ref,
    this.groupId,
    required this.mode,
  });

  final BuildContext context;
  final WidgetRef ref;
  final String? groupId;
  final String mode;

  Future<void> handleDeleteSwitch() async {
    if (mode == 'create') {
      _switch();
    } else if (mode == 'setting') {
      _switchToTrue();
      final navigator = DeleteMemberSwitchModalNavigator(context, groupId);
      await navigator.showModal();
    } else {
      debugPrint('Please set another mode.');
    }
  }

  void _switch() {
    ref.watch(groupMemberDeleteModeProvider.notifier).state =
        !ref.read(groupMemberDeleteModeProvider);
  }

  void _switchToTrue() {
    ref.watch(groupMemberDeleteModeProvider.notifier).state = true;
  }
}
