import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 参加メンバーのアイコン↓
class join_member extends ConsumerWidget {
  const join_member({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 1.0,
            spreadRadius: 2.0,
            offset: Offset(1, 1),
            color: Colors.black12,
          ),
        ],
        borderRadius: BorderRadius.circular(40),
        color: const Color.fromARGB(255, 248, 233, 255),
      ),
      child: const Padding(
        padding: EdgeInsets.only(left: 3.0),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                Icons.group,
                size: 37,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'User1',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//参加メンバーのアイコン↑
