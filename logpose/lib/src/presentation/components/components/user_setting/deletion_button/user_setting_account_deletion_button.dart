import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../navigations/modals/to_account_deletion_alert_dialog_navigator.dart';

class UserSettingAccountDeletionButton extends ConsumerStatefulWidget {
  const UserSettingAccountDeletionButton({super.key});

  @override
  ConsumerState createState() => _UserSettingAccountDeletionButtonState();
}

class _UserSettingAccountDeletionButtonState
    extends ConsumerState<UserSettingAccountDeletionButton> {
  Future<void> handleToTap() async {
    final navigator = ToAccountDeletionAlertDialogNavigator(context);
    await navigator.showModal();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: handleToTap,
      padding: EdgeInsets.only(left: 0, right: 0),
      color: const Color(0xFF7B61FF),
      borderRadius: BorderRadius.circular(999),
      child: const Icon(
        CupertinoIcons.delete,
        color: CupertinoColors.white,
      ),
    );
  }
}
