import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../navigations/modals/to_account_deletion_confirmation_dialog_navigator.dart';

class AccountDeletionButton extends ConsumerStatefulWidget {
  const AccountDeletionButton({super.key});
  @override
  ConsumerState<AccountDeletionButton> createState() =>
      _AccountDeletionButtonState();
}

class _AccountDeletionButtonState extends ConsumerState<AccountDeletionButton> {
  Future<void> handleToTap() async {
    final navigator =
        ToAccountDeletionConfirmationAlertDialogNavigator(context);
    await navigator.showModal();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 60,
      margin: const EdgeInsets.only(top: 60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),
        color: const Color(0xFF7B61FF),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(225, 127, 145, 145),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: CupertinoButton(
        onPressed: handleToTap,
        child: Center(
          child: Text(
            'アカウントを削除',
            style: const TextStyle(
              fontSize: 18,
              color: CupertinoColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
