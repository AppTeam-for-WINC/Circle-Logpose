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
    final deviceWidth = MediaQuery.of(context).size.width;

    final groupIdList = widget.groupIdList;
    final groupName = ref.watch(groupNameProvider);

    return Row(
      children: [
        const Icon(
          Icons.group_add,
          color: Colors.grey,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: deviceWidth * 0.6,
          ),
          child: CupertinoButton(
            padding: const EdgeInsets.only(left: 10),
            onPressed: () => _showGroupPicker(context, groupIdList),
            child: Text(
              groupName,
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF7B61FF),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
