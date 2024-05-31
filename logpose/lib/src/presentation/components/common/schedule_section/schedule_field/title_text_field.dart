import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/text_field/schedule_title_controller_provider.dart';

class TitleTextField extends ConsumerWidget {
  const TitleTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: deviceWidth * 0.7,
        child: CupertinoTextField(
          controller: ref.watch(scheduleTitleControllerProvider.notifier).state,
          placeholder: 'タイトルを追加',
          placeholderStyle: const TextStyle(color: CupertinoColors.systemGrey),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
          style: const TextStyle(fontSize: 16, color: CupertinoColors.black),
        ),
      ),
    );
  }
}
