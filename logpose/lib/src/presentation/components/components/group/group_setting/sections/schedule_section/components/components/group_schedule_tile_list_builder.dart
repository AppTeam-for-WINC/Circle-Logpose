
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../notifiers/group_schedule_tile_list_builder_notifier.dart';

class GroupScheduleTileListBuilder extends ConsumerWidget {
  const GroupScheduleTileListBuilder({
    super.key,
    required this.groupId,
    required this.groupName,
  });

  final String groupId;
  final String groupName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileList = ref.watch(
      groupScheduleTileListBuilderNotifierProvider((groupId, groupName)),
    );

    return GridView.count(
      padding: EdgeInsets.zero,
      primary: false,
      shrinkWrap: true,
      crossAxisCount: 1,
      childAspectRatio: 6,
      mainAxisSpacing: 12,
      children: tileList,
    );
  }
}
