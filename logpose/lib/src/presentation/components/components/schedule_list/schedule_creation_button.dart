import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../navigations/modals/schedule_creation_button_modal_navigator.dart';

class ScheduleCreationButton extends ConsumerStatefulWidget {
  const ScheduleCreationButton({super.key});
  @override
  ConsumerState<ScheduleCreationButton> createState() =>
      _ScheduleCreationButtonState();
}

class _ScheduleCreationButtonState
    extends ConsumerState<ScheduleCreationButton> {
  Future<void> handleToTap() async {
    final navigator = ScheduleCreationButtonModalNavigator(context);
    await navigator.showModal();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),
        color: const Color.fromARGB(255, 107, 88, 252),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(225, 127, 145, 145),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: CupertinoButton(
        onPressed: handleToTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(60)),
              child: const Icon(
                CupertinoIcons.add,
                size: 25,
                color: CupertinoColors.white,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              '予定を作成',
              style: TextStyle(fontSize: 18, color: CupertinoColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
