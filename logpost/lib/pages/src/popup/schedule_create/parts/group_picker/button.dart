import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../schedule_create_controller.dart';
import 'modal.dart';

class GroupPickerButton extends ConsumerStatefulWidget {
  const GroupPickerButton({
    super.key,
    required this.groupIdList,
  });

  final List<String> groupIdList;
  @override
  ConsumerState<GroupPickerButton> createState() => _GroupPickerButtonState();
}

class _GroupPickerButtonState extends ConsumerState<GroupPickerButton> {
  void _showGroupPicker(
    BuildContext context,
    List<String> groupIdList,
  ) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return GroupPickerModal(
          groupIdList: groupIdList,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final groupIdList = widget.groupIdList;
    final groupName = ref.watch(groupNameProvider);

    return Row(
      children: [
        const Icon(
          Icons.group_add,
          color: Colors.grey,
        ),
        CupertinoButton(
          onPressed: () => _showGroupPicker(context, groupIdList),
          child: Text(
            groupName,
            style: const TextStyle(fontSize: 18, color: Color(0xFF7B61FF)),
          ),
        ),
      ],
    );
  }
}
