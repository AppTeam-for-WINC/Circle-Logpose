import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../controllers/providers/group/member/set_group_member_list_provider.dart';
import '../../../../../../controllers/providers/group/mode/group_member_delete_mode_provider.dart';

import '../../../../../../models/user/user.dart';

class SetGroupMember extends ConsumerStatefulWidget {
  const SetGroupMember({super.key, required this.userProfile});
  final UserProfile userProfile;
  @override
  ConsumerState<SetGroupMember> createState() => _GroupMemberState();
}

class _GroupMemberState extends ConsumerState<SetGroupMember> {
  @override
  Widget build(BuildContext context) {
    final userProfile = widget.userProfile;
    return Stack(
      children: [
        SizedBox.expand(
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
        if (ref.watch(setMemberDeleteModeProvider))
          Positioned(
            top: 0,
            right: 0,
            child: CupertinoButton(
              onPressed: () async {
                ref.watch(setGroupMemberListProvider.notifier).removeMember(
                  userProfile.accountId,
                );
              },
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 231, 231),
                  borderRadius: BorderRadius.all(Radius.circular(999)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 2,
                      offset: Offset(0, 2),
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
