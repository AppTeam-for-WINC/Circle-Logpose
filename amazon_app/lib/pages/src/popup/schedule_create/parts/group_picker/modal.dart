import 'package:amazon_app/pages/src/home/parts/group/controller/joined_group_controller.dart';
import 'package:amazon_app/pages/src/popup/schedule_create/parts/group_picker/riverpod.dart';
import 'package:amazon_app/pages/src/popup/schedule_create/schedule_create_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupPickerModal extends ConsumerWidget {
  const GroupPickerModal({
    super.key,
    required this.groups,
  });
  final List<GroupWithId> groups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupScheduleNotifier =
        ref.watch(createGroupScheduleProvider.notifier);
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
                groupScheduleNotifier.setSchedule(id);
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
