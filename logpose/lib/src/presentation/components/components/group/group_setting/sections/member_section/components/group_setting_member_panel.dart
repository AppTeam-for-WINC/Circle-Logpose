import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/group_setting_member_panel_label.dart';
import 'components/group_setting_member_panel_member_list.dart';

class GroupSettingMemberPanel extends ConsumerStatefulWidget {
  const GroupSettingMemberPanel({super.key, required this.groupId});
  
  final String groupId;

  @override
  ConsumerState createState() => _GroupSettingMemberPanelState();
}

class _GroupSettingMemberPanelState
    extends ConsumerState<GroupSettingMemberPanel> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final groupId = widget.groupId;

    return Center(
      child: Container(
        width: deviceWidth * 0.85,
        margin: const EdgeInsets.only(top: 10, left: 6, bottom: 5),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 3),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GroupSettingMemberPanelLabel(),
              GroupSettingMemberPanelMemberList(groupId: groupId),
            ],
          ),
        ),
      ),
    );
  }
}
