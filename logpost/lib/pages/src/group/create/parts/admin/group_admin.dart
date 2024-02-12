import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../database/user/user.dart';

class GroupAdminMember extends ConsumerWidget {
  const GroupAdminMember({super.key, required this.adminUserProfile});
  final UserProfile adminUserProfile;
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
        color: const Color.fromARGB(255, 233, 200, 248),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 3),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      adminUserProfile.image,
                    ),
                    fit: BoxFit.cover, // 画像のフィットを指定
                  ),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  adminUserProfile.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
