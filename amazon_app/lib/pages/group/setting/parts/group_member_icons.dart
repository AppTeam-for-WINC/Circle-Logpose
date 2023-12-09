import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupMemberIcons extends ConsumerWidget {
  // 参加メンバーのアイコンを取得するように変更してください
  final memberIcon = Icons.perm_identity;
  final int maxIcons = 8;

  const GroupMemberIcons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> iconWidgets = [];

    int iconCount = 0;
    while (iconCount < maxIcons) {
      iconWidgets.add(
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: Icon(
            memberIcon,
            size: 30,
          ),
        ),
      );
      iconCount++;
    }

    if (iconCount >= maxIcons) {
      iconWidgets.add(
        const Text(
          '…',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 30,
          ),
        ),
      );
    }

    return Row(
      children: iconWidgets,
    );
  }
}