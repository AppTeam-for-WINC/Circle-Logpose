import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/providers/sort/sorted_group_and_schedule_id_provider.dart';
import '../../models/custom/group_profile_and_schedule_and_id_model.dart';
import 'components/schedule_card.dart';

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

    Widget scheduleCardList(List<GroupProfileAndScheduleAndId> groupDataList) {
      return Column(
        children: [
          ...groupDataList.map((groupData) {
            return ScheduleCard(groupData: groupData);
          }),
          const SizedBox(
            height: 200,
          ),
        ],
      );
    }

    // 代わりにListView.builder を用いても良い。
    Widget asyncScheduleCardList() {
      final data = ref.watch(sortedGroupAndScheduleAndIdProvider);

      return data.when(
        data: (groupDataList) {
          if (groupDataList.isEmpty) {
            return const SizedBox.shrink();
          }

          return scheduleCardList(groupDataList);
        },
        loading: () => const SizedBox.shrink(),
        error: (error, stack) => Text('$error'),
      );
    }

    return Container(
      width: deviceWidth * 0.9,
      height: deviceHeight,
      color: const Color(0xFFF5F3FE),
      child: SingleChildScrollView(
        child: Column(
          children: [
            asyncScheduleCardList(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
