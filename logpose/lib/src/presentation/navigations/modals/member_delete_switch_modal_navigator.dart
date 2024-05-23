import 'package:flutter/cupertino.dart';

import '../../components/components/popup/delete_member_list/delete_member_list.dart';

class MemberDeleteSwitchModalNavigator {
  MemberDeleteSwitchModalNavigator(this.context, this.groupId);

  final BuildContext context;
  final String? groupId;

  Future<void> showModal() async {
    await showCupertinoModalPopup<DeleteMemberList>(
      context: context,
      builder: (BuildContext context) {
        return DeleteMemberList(groupId: groupId!);
      },
    );
  }
}
