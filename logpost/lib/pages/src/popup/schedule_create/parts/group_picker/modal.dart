import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../home/parts/group/controller/joined_group_controller.dart';
import '../../schedule_create_controller.dart';

class GroupPickerModal extends ConsumerStatefulWidget {
  const GroupPickerModal({
    super.key,
    required this.groups,
  });
  final List<GroupWithId> groups;
  @override
  ConsumerState createState() => _GroupPickerModalState();
}

class _GroupPickerModalState extends ConsumerState<GroupPickerModal> {
  @override
  void initState() {
    super.initState();
    // 選択肢が1つだけの場合、自動的にその選択肢を選択。
    if (widget.groups.length == 1) {
      final id = widget.groups[0].groupId;
      final name = widget.groups[0].group.name;
      final scheduleNotifier = ref.read(createGroupScheduleProvider.notifier);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scheduleNotifier.setGroupId(id);
        ref.read(groupNameProvider.notifier).state = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final groups = widget.groups;
    final scheduleNotifier = ref.watch(createGroupScheduleProvider.notifier);

    return Container(
      height: 200,
      width: 360,
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(36),
      ),
      child: Column(
        children: [
          Expanded(
            child: CupertinoPicker(
              itemExtent: 40,
              onSelectedItemChanged: (int index) {
                final id = groups[index].groupId;
                final name = groups[index].group.name;
                scheduleNotifier.setGroupId(id);
                ref.watch(groupNameProvider.notifier).state = name;
              },
              children: groups
                  .map(
                    (groupWithId) => Center(
                      child: Text(
                        groupWithId.group.name,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          CupertinoButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
