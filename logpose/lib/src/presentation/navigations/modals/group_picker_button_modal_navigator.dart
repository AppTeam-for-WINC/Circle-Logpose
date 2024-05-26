import 'package:flutter/cupertino.dart';

import '../../components/common/schedule_section/schedule_group_selector/components/components/group_picker_modal.dart';

class GroupPickerButtonModalNavigator {
  GroupPickerButtonModalNavigator({
    required this.context,
    required this.groupIdList,
  });

  final BuildContext context;
  final List<String> groupIdList;

  Future<void> showModal() async {
    await showCupertinoModalPopup<GroupPickerModal>(
      context: context,
      builder: (BuildContext context) {
        return GroupPickerModal(groupIdList: groupIdList);
      },
    );
  }
}
