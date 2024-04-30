import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../views/src/group/setting/group_setting_page.dart';
import 'components/async_group_and_id.dart';

class GroupBox extends ConsumerStatefulWidget {
  const GroupBox({super.key, required this.groupId});

  final String groupId;
  @override
  ConsumerState createState() => _GroupBoxState();
}

class _GroupBoxState extends ConsumerState<GroupBox> {
  Future<void> onTap() async {
    await Navigator.push(
      context,
      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
        builder: (context) => GroupSettingPage(groupId: widget.groupId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final groupId = widget.groupId;

    return GestureDetector(
      onTap: onTap,
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
        child: AsyncGroupAndId(groupId: groupId),
      ),
    );
  }
}
