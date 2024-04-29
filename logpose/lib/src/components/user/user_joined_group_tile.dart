import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/providers/utils/group_and_id_provider.dart';
import '../image/custom_cached_network_image.dart';

class UserJoinedGroupTile extends ConsumerStatefulWidget {
  const UserJoinedGroupTile({super.key, required this.groupId});
  final String groupId;
  
  @override
  ConsumerState createState() => _UserJoinedGroupTileState();
}

class _UserJoinedGroupTileState extends ConsumerState<UserJoinedGroupTile> {
  @override
  Widget build(BuildContext context) {
    final asyncGroupAndId = ref.watch(watchGroupAndIdProvider(widget.groupId));

    return asyncGroupAndId.when(
      data: (data) {
        if (data == null) {
          return const Text('No group data.');
        }

        return GestureDetector(
          onTap: () {},
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 244, 219, 251),
              borderRadius: BorderRadius.circular(80),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: CustomCachedNetworkImage(
                      imagePath: data.groupProfile.image,
                      width: 25,
                      height: 25,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      data.groupProfile.name,
                      style: const TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => Text('$error'),
    );
  }
}
