import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/components/schedule_list/components/schedule_card.dart';

import '../providers/sort/sorted_group_and_schedule_id_provider.dart';

final scheduleCardListNotifierProvider =
    StateNotifierProvider.autoDispose<_ScheduleCardListNotifier, List<Widget>>(
  _ScheduleCardListNotifier.new,
);

class _ScheduleCardListNotifier extends StateNotifier<List<Widget>> {
  _ScheduleCardListNotifier(this.ref) : super([]) {
    _initScheduleCardList();
  }

  final Ref ref;

  Future<void> _initScheduleCardList() async {
    final data = await ref.watch(sortedGroupAndScheduleAndIdProvider.future);
    final scheduleCardList = Column(
      children: [
        ...data.map((groupData) {
          return ScheduleCard(groupData: groupData);
        }),
        const SizedBox(height: 200),
      ],
    );

    state = [scheduleCardList];
  }
}
