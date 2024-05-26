import 'package:flutter/cupertino.dart';

import '../../components/components/popup/member_addition/member_addition.dart';

class ToMemberAdditionNavigator {
  ToMemberAdditionNavigator(this.context);

  final BuildContext context;

  Future<void> showModal(String? groupId) async {
    await showCupertinoModalPopup<MemberAddition>(
      context: context,
      builder: (BuildContext context) {
        return MemberAddition(groupId: groupId);
      },
    );
  }
}
