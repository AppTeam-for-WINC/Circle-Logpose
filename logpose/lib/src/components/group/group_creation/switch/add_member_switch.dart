import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../popup/add_member/add_member.dart';

class AddMemberSwitch extends ConsumerWidget {
  const AddMemberSwitch({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> onPressed() async {
      await showCupertinoModalPopup<AddMember>(
        context: context,
        builder: (BuildContext context) {
          return const AddMember(groupId: null);
        },
      );
    }

    return CupertinoButton(
      onPressed: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFD8EB61),
          borderRadius: BorderRadius.circular(44),
        ),
        child: const Center(
          child: Icon(
            CupertinoIcons.person_add_solid,
            size: 20,
            color: CupertinoColors.black,
          ),
        ),
      ),
    );
  }
}
