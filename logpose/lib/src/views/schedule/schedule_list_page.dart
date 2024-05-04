import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/bottom_gradation/bottom_gradation.dart';
import '../../components/schedule_card_list/schedule_card_list.dart';
import '../../components/schedule_creation_button/schedule_creation_button.dart';
import '../../controllers/providers/group/group/watch_joined_group_exist_provider.dart';

class ScheduleListPage extends ConsumerStatefulWidget {
  const ScheduleListPage({super.key});
  @override
  ConsumerState createState() => _ScheduleListState();
}

class _ScheduleListState extends ConsumerState<ScheduleListPage> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final groupExist = ref.watch(watchJoinedGroupExistProvider);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFFF5F3FE),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            top: deviceHeight * 0.14,
            child: const ScheduleCardList(),
          ),
          const Positioned(
            bottom: 0, // 画面の底部に配置
            child: BottomGradation(),
          ),
          if (groupExist is AsyncLoading)
            const Center(child: CupertinoActivityIndicator()),
          if (groupExist is AsyncError)
            Center(child: Text('Error: ${groupExist.error}')),

          // グループが存在する場合のみボタンを表示
          if (groupExist is AsyncData && groupExist.value == true)
            Positioned(
              top: deviceHeight * 0.875,
              child: const ScheduleCreationButton(),
            ),
        ],
      ),
    );
  }
}
