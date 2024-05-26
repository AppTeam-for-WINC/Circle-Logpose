import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../navigations/to_schedule_list_and_joined_group_tab_slider.dart';

class ScheduleTab extends ConsumerStatefulWidget {
  const ScheduleTab({super.key});

  @override
  ConsumerState createState() => _ScheduleTabState();
}

class _ScheduleTabState extends ConsumerState<ScheduleTab> {
  Future<void> _handleToTap() async {
    final navigator = ToScheduleListAndJoinedGroupTabSliderNavigator(context);
    await navigator.moveToPage();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleToTap,
      child: Container(
        width: 180,
        height: 55,
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Container(
              width: 33,
              height: 33,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 192, 97),
                borderRadius: BorderRadius.circular(33),
              ),
              child: const Center(
                child: Icon(CupertinoIcons.home),
              ),
            ),
            const Text(
              '出席簿',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 200, 150, 76),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
