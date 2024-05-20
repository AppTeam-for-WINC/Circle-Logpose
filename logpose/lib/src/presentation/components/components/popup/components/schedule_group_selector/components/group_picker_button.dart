import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../domain/providers/group/group/selected_group_name_provider.dart';
import '../../schedule_group_picker_button/group_picker_modal.dart';

class GroupPickerButton extends ConsumerStatefulWidget {
  const GroupPickerButton({super.key, required this.groupIdList});
  final List<String> groupIdList;

  @override
  ConsumerState<GroupPickerButton> createState() => _GroupPickerButtonState();
}

class _GroupPickerButtonState extends ConsumerState<GroupPickerButton> {
  void _showGroupPicker(BuildContext context, List<String> groupIdList) {
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

    return CupertinoButton(
      padding: const EdgeInsets.only(left: 10),
      onPressed: () => _showGroupPicker(context, groupIdList),
      child: Text(
        ref.watch(selectedGroupNameProvider),
        style: const TextStyle(
          fontSize: 18,
          color: Color(0xFF7B61FF),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
