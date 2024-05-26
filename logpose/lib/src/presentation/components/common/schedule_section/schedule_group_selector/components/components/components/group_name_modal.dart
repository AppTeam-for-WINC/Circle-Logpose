import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../domain/model/group_and_id_model.dart';

import '../../../../../../../handlers/group_name_modal_handler.dart';

import '../../../../../../../providers/group/group/fetch_group_and_id_list_provider.dart';

class GroupNameModal extends ConsumerWidget {
  const GroupNameModal({super.key, required this.groupIdList});

  final List<String> groupIdList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onSelectedItemChanged(List<GroupAndId> data, int index) {
      final groupId = data[index].groupId;
      final groupName = data[index].groupProfile.name;
      GroupNameModalHandler(ref: ref, groupId: groupId, groupName: groupName)
          .handleToSelectedGroup();
    }

    final asyncGroupAndIdList =
        ref.watch(fetchGroupAndIdListProvider(groupIdList));

    return asyncGroupAndIdList.when(
      data: (data) {
        return SizedBox(
          height: 150,
          child: CupertinoPicker(
            itemExtent: 40,
            onSelectedItemChanged: (int index) =>
                onSelectedItemChanged(data, index),
            children: data
                .map(
                  (groupAndId) =>
                      Center(child: Text(groupAndId.groupProfile.name)),
                )
                .toList(),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => Text('$error'),
    );
  }
}
