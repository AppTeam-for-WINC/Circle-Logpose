import 'package:flutter/cupertino.dart';

import '../../components/components/popup/delete_member_list/member_list_delete.dart';

class MemberDeleteSwitchModalNavigator {
  MemberDeleteSwitchModalNavigator(this.context, this.groupId);

  final BuildContext context;
  final String? groupId;

  Future<void> showModal() async {
    await showCupertinoModalPopup<MemberListDelete>(
      context: context,
      builder: (BuildContext context) {
        return MemberListDelete(groupId: groupId!);
      },
    );
  }
}
