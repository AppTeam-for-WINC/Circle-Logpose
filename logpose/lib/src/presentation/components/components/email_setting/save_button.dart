import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/providers/error_message/email_error_message_provider.dart';
import '../../../../domain/providers/text_field/email_field_provider.dart';

import '../../../../domain/usecase/facade/auth_facade.dart';
import '../../../pages/user/user_setting_page.dart';

class SaveButton extends ConsumerStatefulWidget {
  const SaveButton({super.key, required this.password});
  final String password;

  @override
  ConsumerState<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends ConsumerState<SaveButton> {
  Future<String?> _updateEmail() async {
    final authFacade = ref.read(authFacadeProvider);
    final newEmail = ref.watch(emailFieldProvider('')).text;

    return authFacade.updateUserEmail(newEmail, widget.password);
  }

  Future<void> _pushAndRemoveUntil() async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<UserSettingPage>>(
        builder: (context) => const UserSettingPage(),
      ),
      (_) => false,
    );
  }

  Future<void> _save() async {
    final updateError = await _updateEmail();
    if (updateError != null) {
      ref.watch(emailErrorMessageProvider.notifier).state = updateError;
      return;
    }

    ref.watch(emailFieldProvider('')).clear();

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
      margin: const EdgeInsets.only(top: 100),
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        backgroundColor: const Color.fromARGB(255, 123, 97, 255),
        onPressed: _save,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(Icons.download, size: 30, color: Colors.white),
            ),
            const Text(
              '変更を保存',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
