import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../domain/model/group_and_id_model.dart';
import '../../../../../../../domain/providers/group/group/listen_group_and_id_provider.dart';

import '../../../../../common/custom_image/custom_image.dart';

class GroupAndImageBuilder extends ConsumerWidget {
  const GroupAndImageBuilder({super.key, required this.groupId});
  
  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncGroupAndId = ref.watch(listenGroupAndIdProvider(groupId));

    return asyncGroupAndId.when(
      data: _GroupAndImage.new,
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => Text('$error'),
    );
  }
}

class _GroupAndImage extends StatelessWidget {
  const _GroupAndImage(this.data);

  final GroupAndId? data;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Text('No group data.');
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImage(
          imagePath: data!.groupProfile.image,
          height: 45,
          width: 45,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            data!.groupProfile.name,
            style: const TextStyle(
              fontSize: 16,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      ],
    );
  }
}
