import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/controllers/user/update_account_id.dart';
import '../../controllers/providers/error/account_id_error_message_provider.dart';
import '../../controllers/providers/text_field/account_id_field_provider.dart';
import '../../controllers/providers/user/set_user_profile_provider.dart';
import '../../views/user/user_setting_page.dart';

class SaveButton extends ConsumerStatefulWidget {
  const SaveButton({super.key});
  @override
  ConsumerState<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends ConsumerState<SaveButton> {
  Future<String?> _update(String newAccountId) async {
    return UpdateAccountId.update(newAccountId);
  }

  // Init
  void _setNewAccountId(String newAccountId) {
    ref
        .watch(setUserProfileDataProvider.notifier)
        .setNewAccountId(newAccountId);
  }

  Future<void> _pushAndRemoveUntil() async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
        builder: (context) => const UserSettingPage(),
      ),
      (_) => false,
    );
  }

  Future<void> _save() async {
    final newAccountId = ref.read(accountIdFieldProvider('')).text;
    final errorMessage = await _update(newAccountId);
    if (errorMessage != null) {
      ref.watch(accountIdErrorMessageProvider.notifier).state = errorMessage;
      return;
    }
    _setNewAccountId(newAccountId);

    if (!mounted) {
      return;
    }
    await _pushAndRemoveUntil();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 196,
      height: 58,
      margin: const EdgeInsets.only(top: 60),
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        backgroundColor: const Color.fromARGB(255, 123, 97, 255),
        onPressed: _save,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(
                CupertinoIcons.arrow_down_doc,
                size: 30,
              ),
            ),
            const Text(
              '変更を保存',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
