import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../navigations/modals/to_addition_navigator.dart';

class MemberAdditionSwitch extends ConsumerWidget {
  const MemberAdditionSwitch({super.key, this.groupId});
  final String? groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> showModal() async {
      final navigator = ToMemberAdditionNavigator(context);
      await navigator.showModal(groupId);
    }

    return CupertinoButton(
      onPressed: showModal,
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
