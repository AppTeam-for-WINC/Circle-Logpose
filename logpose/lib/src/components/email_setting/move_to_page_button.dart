import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/error/password_error_message_provider.dart';
import '../../domain/providers/text_field/password_field_provider.dart';
import '../../domain/validation/password_validation.dart';

import '../../views/user/email/email_setting_next_page.dart';

class MoveToNextPageButton extends ConsumerStatefulWidget {
  const MoveToNextPageButton({super.key});
  @override
  ConsumerState<MoveToNextPageButton> createState() =>
      _MoveToNextPageButtonState();
}

class _MoveToNextPageButtonState extends ConsumerState<MoveToNextPageButton> {
  // Validate password
  String? _validationPassword(String password) {
    return PasswordValidation.validation(password);
  }

  Future<void> _pushAndRemoveUntil(String password) async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<EmailSettingNextPage>>(
        builder: (context) => EmailSettingNextPage(password: password),
      ),
      (_) => false,
    );
  }

  Future<void> _onPressed() async {
    final password = ref.watch(passwordFieldProvider('')).text;
    final errorMessage = _validationPassword(password);
    if (errorMessage != null) {
      ref.watch(passwordErrorMessageProvider.notifier).state = errorMessage;
      return;
    }
    await _pushAndRemoveUntil(password);
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
        onPressed: _onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(Icons.download, size: 30, color: Colors.white),
            ),
            const Text(
              '次へ',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
