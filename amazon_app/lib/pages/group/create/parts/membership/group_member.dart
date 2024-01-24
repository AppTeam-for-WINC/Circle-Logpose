import 'package:amazon_app/database/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupMember extends ConsumerWidget {
  const GroupMember({super.key, required this.userProfile});
  final UserProfile userProfile;

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
      child: Padding(
        padding: const EdgeInsets.only(left: 3),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // image: NetworkImage(),
                    image: AssetImage(
                      userProfile.image,
                    ),
                    fit: BoxFit.cover, // 画像のフィットを指定
                  ),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                userProfile.name,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
