import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../handlers/email_save_button_handler.dart';

import '../../common/save_button.dart';

class EmailSaveButton extends ConsumerStatefulWidget {
  const EmailSaveButton({super.key, required this.password});
  final String password;

  @override
  ConsumerState<EmailSaveButton> createState() => _EmailSaveButtonState();
}

class _EmailSaveButtonState extends ConsumerState<EmailSaveButton> {
  Future<void> _handleEmail() async {
    final handler = EmailSaveButtonHandler(
      context: context,
      ref: ref,
      password: widget.password,
    );
    await handler.handleEmail();
  }

  @override
  Widget build(BuildContext context) {
    return SaveButton(label: '変更を保存', onPressed: _handleEmail);
  }
}
