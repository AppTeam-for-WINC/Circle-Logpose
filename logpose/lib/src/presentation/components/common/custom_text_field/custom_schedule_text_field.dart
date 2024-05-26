import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomScheduleTextField extends ConsumerWidget {
  const CustomScheduleTextField({
    super.key,
    required this.textController,
    required this.placeholder,
  });

  final TextEditingController textController;
  final String placeholder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoTextField(
      controller: textController,
      placeholder: placeholder,
      placeholderStyle: const TextStyle(color: CupertinoColors.systemGrey),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(style: BorderStyle.none)),
      ),
      style: const TextStyle(fontSize: 16, color: CupertinoColors.black),
    );
  }
}
