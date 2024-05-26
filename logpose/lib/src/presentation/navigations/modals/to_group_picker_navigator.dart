import 'package:flutter/cupertino.dart';

import '../../components/common/schedule_section/schedule_group_selector/components/components/group_picker_modal.dart';

class ToGroupPickerNavigator {
  ToGroupPickerNavigator(this.context);

  final BuildContext context;

  Future<void> showModal(List<String> groupIdList) async {
    await showCupertinoModalPopup<GroupPickerModal>(
      context: context,
      builder: (BuildContext context) {
        return GroupPickerModal(groupIdList: groupIdList);
      },
    );
  }
}
