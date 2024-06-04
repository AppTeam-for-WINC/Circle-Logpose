import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/responsive_util.dart';

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

  void _initScheduleCardList() {
    final asyncData = ref.watch(sortedGroupAndScheduleAndIdProvider);
    final scheduleCardList = asyncData.when(
      data: (dataList) {
        return Column(
          children: [
            ...dataList.map((data) {
              return ScheduleCard(groupData: data);
            }),
            _buildSizedBox(),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => Text('$error'),
    );

    state = [scheduleCardList];
  }

  Widget _buildSizedBox() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtil.isMobile(context)) {
          return const SizedBox(height: 200);
        } else if (ResponsiveUtil.isTablet(context)) {
          return const SizedBox(height: 400);
        } else {
          return const SizedBox(height: 600);
        }
      },
    );
  }
}
