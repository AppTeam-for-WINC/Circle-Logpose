import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/custom_image/custom_image.dart';
import '../../../../../controllers/providers/utils/group_and_id_provider.dart';

class AsyncGroupAndId extends ConsumerWidget {
  const AsyncGroupAndId({super.key, required this.groupId});
  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncGroupAndId = ref.watch(watchGroupAndIdProvider(groupId));
    
    return asyncGroupAndId.when(
      data: (data) {
        if (data == null) {
          return const Text('No group data.');
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImage(
              imagePath: data.groupProfile.image,
              height: 45,
              width: 45,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                data.groupProfile.name,
                style: const TextStyle(
                  fontSize: 16,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => Text('$error'),
    );
  }
}
