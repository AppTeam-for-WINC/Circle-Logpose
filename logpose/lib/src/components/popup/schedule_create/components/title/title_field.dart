import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../controllers/providers/group/schedule/text/schedule_title_controller_provider.dart';

class TitleField extends ConsumerWidget {
  const TitleField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;

    void onChanged(String text) {
      ref.read(scheduleTitleControllerProvider.notifier).state.text = text;
    }

    return Center(
      child: SizedBox(
        width: deviceWidth * 0.7,
        child: CupertinoTextField(
          controller: ref.watch(scheduleTitleControllerProvider.notifier).state,
          placeholder: 'タイトルを追加',
          placeholderStyle: const TextStyle(color: CupertinoColors.systemGrey),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(),
            ),
          ),
          style: const TextStyle(
            fontSize: 16,
            color: CupertinoColors.black,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
