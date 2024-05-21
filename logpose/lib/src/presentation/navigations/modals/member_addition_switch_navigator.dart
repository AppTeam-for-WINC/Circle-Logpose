import 'package:flutter/cupertino.dart';

import '../../components/components/popup/add_member/add_member.dart';

class MemberAdditionSwitchModalNavigator {
  MemberAdditionSwitchModalNavigator(this.context, this.groupId);

  final BuildContext context;
  final String? groupId;

  Future<void> showModal() async {
    await showCupertinoModalPopup<AddMember>(
      context: context,
      builder: (BuildContext context) {
        return AddMember(groupId: groupId);
      },
    );
  }
}
