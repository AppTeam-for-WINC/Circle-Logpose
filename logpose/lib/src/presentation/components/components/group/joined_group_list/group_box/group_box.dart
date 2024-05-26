import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../navigations/to_group_setting_page_navigator.dart';

import 'components/group_and_image_builder.dart';

class GroupBox extends ConsumerStatefulWidget {
  const GroupBox({super.key, required this.groupId});

  final String groupId;
  @override
  ConsumerState createState() => _GroupBoxState();
}

class _GroupBoxState extends ConsumerState<GroupBox> {
  Future<void> handleToTap() async {
    final navigator = ToGroupSettingPageNavigator(context);
    await navigator.moveToPage(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    final groupId = widget.groupId;

    return GestureDetector(
      onTap: handleToTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: CupertinoColors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0, 2),
              color: Color.fromRGBO(0, 0, 0, 0.15),
            ),
          ],
        ),
        child: GroupAndImageBuilder(groupId: groupId),
      ),
    );
  }
}
