import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../handlers/password_save_button_handler.dart';

import '../../common/save_button.dart';

class PasswordSaveButton extends ConsumerStatefulWidget {
  const PasswordSaveButton({super.key});
  @override
  ConsumerState<PasswordSaveButton> createState() => _PasswordSaveButtonState();
}

class _PasswordSaveButtonState extends ConsumerState<PasswordSaveButton> {
  Future<void> _handlePassword() async {
    final hanlder = PasswordSaveButtonHandler(context: context, ref: ref);
    await hanlder.handlePassword();
  }

  @override
  Widget build(BuildContext context) {
    return SaveButton(label: '変更を保存', onPressed: _handlePassword);
  }
}
