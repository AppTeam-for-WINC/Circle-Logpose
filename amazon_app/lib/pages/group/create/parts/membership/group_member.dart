import 'package:amazon_app/database/user/user.dart';
import 'package:amazon_app/pages/group/create/parts/contents/group_contents_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupMember extends ConsumerWidget {
  // final VoidCallback onTap;

  // const MyGridItem({Key? key, required this.onTap}) : super(key: key);
  const GroupMember({super.key, required this.userProfile});
  final UserProfile? userProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupAddData = ref.watch(groupAddDataProvider.notifier);

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
      child: Padding(
        padding: const EdgeInsets.only(left: 3),
        child: Row(
          children: [
             Padding(
              padding: const EdgeInsets.only(left: 5),
              // Image.network()
              child: Image.asset(
                groupAddData.userImage!,
                width: 37,
                height: 37,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                groupAddData.username!,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
