import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupMember extends ConsumerWidget {
  // final VoidCallback onTap;

  // const MyGridItem({Key? key, required this.onTap}) : super(key: key);
  const GroupMember({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 2,
            offset: Offset(1, 1),
            color: Colors.black12,
          ),
        ],
        borderRadius: BorderRadius.circular(40),
        color: const Color.fromARGB(255, 248, 233, 255),
      ),
      child: const Padding(
        padding: EdgeInsets.only(left: 3),
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
