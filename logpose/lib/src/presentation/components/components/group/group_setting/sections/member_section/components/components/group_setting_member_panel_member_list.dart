import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../notifiers/set_group_member_list_notifier.dart';

import '../../../../../../../common/custom_image/custom_image.dart';

import 'components/group_member_image_list.dart';

class GroupSettingMemberPanelMemberList extends ConsumerStatefulWidget {
  const GroupSettingMemberPanelMemberList({super.key, required this.groupId});

  final String groupId;

  @override
  ConsumerState createState() => _GroupSettingMemberPanelMemberListState();
}

class _GroupSettingMemberPanelMemberListState
    extends ConsumerState<GroupSettingMemberPanelMemberList> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: Alignment.centerLeft,
        widthFactor: 0.8,
        child: SizedBox(
          child: Row(
            children: [
              GroupMemberImageList(role: 'admin', groupId: widget.groupId),
              GroupMemberImageList(role: 'membership', groupId: widget.groupId),
              ...ref.watch(setGroupMemberListNotifierProvider).map(
                    (memberProfile) => CustomImage(
                      imagePath: memberProfile.image,
                      width: 30,
                      height: 30,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
