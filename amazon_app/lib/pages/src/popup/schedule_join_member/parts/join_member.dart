import 'package:amazon_app/database/user/user.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinMember extends ConsumerStatefulWidget {
  const JoinMember({super.key, required this.userProfile});
  final UserProfile userProfile;

  @override
  ConsumerState<JoinMember> createState() => _JoinMemberState();
}

class _JoinMemberState extends ConsumerState<JoinMember> {
  @override
  Widget build(BuildContext context) {
    final userProfile = widget.userProfile;

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
      child: Container(
        padding: const EdgeInsets.only(left: 3),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: userProfile.image.startsWith('http')
                        ? NetworkImage(userProfile.image)
                        : AssetImage(userProfile.image) as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  userProfile.name,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
