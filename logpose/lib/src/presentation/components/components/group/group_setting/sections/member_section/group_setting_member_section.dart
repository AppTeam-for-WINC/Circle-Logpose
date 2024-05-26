import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/member_switch/delete_member_switch.dart';
import '../../../../../common/member_switch/member_addition_switch.dart';

import 'components/group_setting_member_panel.dart';

class GroupSettingMemberSection extends ConsumerStatefulWidget {
  const GroupSettingMemberSection({super.key, required this.groupId});

  final String groupId;
  
  @override
  ConsumerState createState() => _GroupSettingMemberSectionState();
}

class _GroupSettingMemberSectionState
    extends ConsumerState<GroupSettingMemberSection> {
  @override
  Widget build(BuildContext context) {
    final groupId = widget.groupId;

    return Stack(
      children: [
        GroupSettingMemberPanel(groupId: groupId),
        Positioned(
          top: -15,
          right: -15,
          child: MemberAdditionSwitch(groupId: groupId),
        ),
        Positioned(
          top: 25,
          right: -15,
          child: MemberDeleteSwitch(groupId: groupId, mode: 'setting'),
        ),
      ],
    );
  }
}
