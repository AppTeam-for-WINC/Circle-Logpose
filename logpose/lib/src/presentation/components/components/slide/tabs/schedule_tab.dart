import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../navigations/to_schedule_list_and_joined_group_tab_slider.dart';
import '../../../common/slide_tab.dart';

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
    return SlideTab(
      label: '出席簿',
      decorationColor: const Color.fromARGB(255, 255, 192, 97),
      textColor: const Color.fromARGB(255, 255, 192, 97),
      icon: CupertinoIcons.home,
      onTap: _handleToTap,
    );
  }
}
