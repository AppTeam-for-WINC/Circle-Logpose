import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../domain/providers/group/group/selected_group_name_provider.dart';
import '../../../../../../popup/schedule_creation/schedule_creation.dart';

class AddScheduleSwitch extends ConsumerWidget {
  const AddScheduleSwitch({super.key, required this.groupId, this.groupName});
  final String groupId;
  final String? groupName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> onTap() async {
      ref.watch(selectedGroupNameProvider.notifier).state =
          groupName!;
      await showCupertinoModalPopup<ScheduleCreation>(
        context: context,
        builder: (BuildContext context) {
          return ScheduleCreation(groupId: groupId);
        },
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFD8EB61),
          borderRadius: BorderRadius.circular(44),
        ),
        child: const Center(
          child: Icon(
            CupertinoIcons.calendar_badge_plus,
            size: 25,
            color: CupertinoColors.black,
          ),
        ),
      ),
    );
  }
}
