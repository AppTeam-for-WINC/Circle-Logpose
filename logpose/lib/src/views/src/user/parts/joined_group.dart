import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/parts/group/controller/joined_group_controller.dart';

class JoinedGroupComponent extends ConsumerStatefulWidget {
  const JoinedGroupComponent({
    super.key,
    required this.groupId,
  });
  final String groupId;
  @override
  ConsumerState createState() => JoinedGroupComponentState();
}

class JoinedGroupComponentState extends ConsumerState<JoinedGroupComponent> {
  @override
  Widget build(BuildContext context) {
    final groupId = widget.groupId;
    final groupProfile = ref.watch(readGroupWithIdProvider(groupId));

    return groupProfile.when(
      data: (data) {
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
                    child: CachedNetworkImage(
                      imageUrl: data.groupProfile.image,
                      placeholder: (context, url) =>
                          const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
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
