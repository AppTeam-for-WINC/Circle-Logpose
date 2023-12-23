import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 参加メンバーのアイコン↓
class PresentMember extends ConsumerWidget {
  // 参加メンバーのアイコンを取得するように変更してください
  final memberIcon = Icons.perm_identity;
  final int maxIcons = 5;

  const PresentMember({super.key});

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
            size: 20,
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
