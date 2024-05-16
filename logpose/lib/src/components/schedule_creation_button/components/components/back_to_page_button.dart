import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/providers/group/schedule/set_group_schedule_provider.dart';

class BackToPageButton extends ConsumerWidget {
  const BackToPageButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void backToPage() {
      ref.watch(setGroupScheduleProvider(null).notifier).initSchedule();
      Navigator.of(context).pop();
    }

    return CupertinoButton(
      padding: const EdgeInsets.only(left: 15, top: 15),
      onPressed: backToPage,
      child: const Icon(
        CupertinoIcons.back,
        color: Color(0xFF7B61FF),
      ),
    );
  }
}
