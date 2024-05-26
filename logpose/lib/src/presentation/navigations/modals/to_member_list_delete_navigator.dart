import 'package:flutter/cupertino.dart';

import '../../components/components/popup/delete_member_list/member_list_delete.dart';

class ToMemberListDeleteNavigator {
  ToMemberListDeleteNavigator(this.context);

  final BuildContext context;

  Future<void> showModal(String? groupId) async {
    await showCupertinoModalPopup<MemberListDelete>(
      context: context,
      builder: (BuildContext context) {
        return MemberListDelete(groupId: groupId!);
      },
    );
  }
}
