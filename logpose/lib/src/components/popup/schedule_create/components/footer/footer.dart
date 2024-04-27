import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'save_button.dart';

class ScheduleFooter extends ConsumerWidget {
  const ScheduleFooter({super.key, this.groupId});

  final String? groupId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: deviceWidth * 0.3,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xFF7B61FF),
        ),
        child: SaveButton(groupId: groupId),
      ),
    );
  }
}
