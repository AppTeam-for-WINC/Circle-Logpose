import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../handlers/account_id_save_button_handler.dart';
import '../../common/save_button.dart';

class AccountIdSaveButton extends ConsumerStatefulWidget {
  const AccountIdSaveButton({super.key});
  @override
  ConsumerState<AccountIdSaveButton> createState() =>
      _AccountIdSaveButtonState();
}

class _AccountIdSaveButtonState extends ConsumerState<AccountIdSaveButton> {
  Future<void> _handleAccountId() async {
    final navigator = AccountIdSaveButtonHandler(context: context, ref: ref);
    await navigator.handleAccountId();
  }

  @override
  Widget build(BuildContext context) {
    return SaveButton(label: '変更を保存', onPressed: _handleAccountId);
  }
}
