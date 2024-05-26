import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/back_to_page_button.dart';

import 'components/group_setting_navigation_middle_bar.dart';
import 'components/group_setting_navigation_trailing_bar.dart';

class GroupSettingNavigationBar extends CupertinoNavigationBar {
  GroupSettingNavigationBar({
    super.key,
    required this.context,
    required this.ref,
    required this.mounted,
    required this.groupId,
  }) : super(
          leading: const BackToPageButton(),
          backgroundColor: const Color.fromARGB(255, 233, 233, 246),
          border: const Border(
            bottom: BorderSide(color: Color.fromARGB(0, 0, 0, 0)),
          ),
          middle: const GroupSettingNavigationMiddleBar(),
          trailing: GroupSettingNavigationTrailingBar(groupId: groupId),
        );

  final BuildContext context;
  final WidgetRef ref;
  final bool mounted;
  final String groupId;
}
