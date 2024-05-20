import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/providers/text_field/schedule_detail_controller_provider.dart';

class DetailTextField extends ConsumerStatefulWidget {
  const DetailTextField({super.key});
  @override
  ConsumerState createState() => _DetailTextFieldState();
}

class _DetailTextFieldState extends ConsumerState<DetailTextField> {
  @override
  Widget build(BuildContext context) {
    void onChanged(String text) {
      ref.watch(scheduleDetailControllerProvider.notifier).state.text = text;
    }

    return CupertinoTextField(
      controller: ref.watch(scheduleDetailControllerProvider.notifier).state,
      placeholder: '詳細を追加',
      placeholderStyle: const TextStyle(color: CupertinoColors.systemGrey),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            style: BorderStyle.none,
          ),
        ),
      ),
      style: const TextStyle(
        fontSize: 16,
        color: CupertinoColors.black,
      ),
      onChanged: onChanged,
    );
  }
}
