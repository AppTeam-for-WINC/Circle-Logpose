import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/providers/group/group/watch_joined_group_profile_provider.dart';

import 'components/group_picker_button.dart';

class GroupSelector extends ConsumerWidget {
  const GroupSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final asyncGroupsIdList = ref.watch(watchJoinedGroupsProfileProvider);

    return asyncGroupsIdList.when(
      data: (data) {
        return Row(
          children: [
            const Icon(CupertinoIcons.group, color: CupertinoColors.systemGrey),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: deviceWidth * 0.6),
              child: GroupPickerButton(groupIdList: data),
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => Text('$error'),
    );
  }
}
