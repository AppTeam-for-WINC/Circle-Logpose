import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../notifiers/schedule_card_list_notifier.dart';

class ScheduleCardList extends ConsumerStatefulWidget {
  const ScheduleCardList({super.key});
  @override
  ConsumerState<ScheduleCardList> createState() {
    return _ScheduleCardListState();
  }
}

class _ScheduleCardListState extends ConsumerState<ScheduleCardList> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final scheduleCardList = ref.watch(scheduleCardListNotifierProvider);

    return Container(
      width: deviceWidth * 0.9,
      height: deviceHeight,
      color: const Color(0xFFF5F3FE),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...scheduleCardList,
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
