import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../database/user/user.dart';

class GroupMember extends ConsumerStatefulWidget {
  const GroupMember({super.key, required this.userProfile});
  final UserProfile userProfile;
  @override
  ConsumerState<GroupMember> createState() => _GroupMemberState();
}

class _GroupMemberState extends ConsumerState<GroupMember> {
  @override
  Widget build(BuildContext context) {
    final userProfile = widget.userProfile;
    return Expanded(
      child: DecoratedBox(
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
          child: Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  child: Container(
                    width: 37,
                    height: 37,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          userProfile.image,
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    userProfile.name,
                    style: const TextStyle(
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
