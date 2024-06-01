import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../providers/group/group/listen_group_and_id_provider.dart';

import 'components/user_joined_group_tile_view.dart';

class UserJoinedGroupTile extends ConsumerStatefulWidget {
  const UserJoinedGroupTile({super.key, required this.groupId});
  
  final String groupId;

  @override
  ConsumerState createState() => _UserJoinedGroupTileState();
}

class _UserJoinedGroupTileState extends ConsumerState<UserJoinedGroupTile> {
  @override
  Widget build(BuildContext context) {
    final asyncGroupAndId = ref.watch(listenGroupAndIdProvider(widget.groupId));

    return asyncGroupAndId.when(
      data: (data) {
        if (data == null) {
          return const Text('No group data.');
        }

        return GestureDetector(
          onTap: () {},
          child: UserJoinedGroupTileView(
            groupImage: data.groupProfile.image,
            groupName: data.groupProfile.name,
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => Text('$error'),
    );
  }
}
