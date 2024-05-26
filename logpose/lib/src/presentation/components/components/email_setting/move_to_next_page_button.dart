import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../handlers/move_to_next_page_button_handler.dart';

import '../../common/save_button.dart';

class MoveToNextPageButton extends ConsumerStatefulWidget {
  const MoveToNextPageButton({super.key});
  @override
  ConsumerState<MoveToNextPageButton> createState() =>
      _MoveToNextPageButtonState();
}

class _MoveToNextPageButtonState extends ConsumerState<MoveToNextPageButton> {
  Future<void> _handlePassword() async {
    final handler = MoveToNextPageButtonHandler(context: context, ref: ref);
    await handler.handlePassword();
  }

  @override
  Widget build(BuildContext context) {
    return SaveButton(label: '次へ', onPressed: _handlePassword);
  }
}
