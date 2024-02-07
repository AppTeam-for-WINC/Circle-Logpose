import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../schedule_join_member/schedule_join_member.dart';
// 参加メンバーのアイコン↓
class PresentMember extends ConsumerWidget {
  // 参加メンバーのアイコンを取得するように変更してください
  const PresentMember({super.key});
  final memberIcon = Icons.perm_identity;
  final int maxIcons = 5;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> iconWidgets = [];

    int iconCount = 0;
    while (iconCount < maxIcons) {
      iconWidgets.add(
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: GestureDetector(
            onTap: () async{
              await showCupertinoModalPopup<ScheduleJoinMember>(
                context: context,
                builder: (BuildContext context) {
                  return const Center(
                    child: ScheduleJoinMember(),
                  );
                },
              );
            },
            child: Icon(
              memberIcon,
              size: 20,
            ),
          ),
        ),
      );
      iconCount++;
    }

    if (iconCount >= maxIcons) {
      iconWidgets.add(
        const Text(
          '…',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Row(
      children: iconWidgets,
    );
  }
}
//参加メンバーのアイコン↑
