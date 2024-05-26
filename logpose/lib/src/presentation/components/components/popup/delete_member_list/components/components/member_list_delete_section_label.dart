import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemberListDeleteSectionLabel extends ConsumerWidget {
  const MemberListDeleteSectionLabel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.group, size: 25),
          SizedBox(width: 10),
          Text(
            'メンバーを削除',
            style: TextStyle(color: CupertinoColors.black),
          ),
        ],
      ),
    );
  }
}
