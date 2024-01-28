import 'package:amazon_app/pages/home/parts/group/controller/joined_group_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinedGroupComponent extends ConsumerStatefulWidget {
  const JoinedGroupComponent({
    super.key,
    required this.groupWithId,
  });
  final GroupWithId groupWithId;
  @override
  ConsumerState createState() => JoinedGroupComponentState();
}

class JoinedGroupComponentState extends ConsumerState<JoinedGroupComponent> {
  @override
  Widget build(BuildContext context) {
    final groupWithId = widget.groupWithId;
    final group = groupWithId.group;
    // final groupId = groupWithId.groupId;

    return GestureDetector(
      onTap: () {},
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(
            216,
            235,
            97,
            0.29,
          ),
          borderRadius: BorderRadius.circular(80),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: group.image,
                placeholder: (context, url) =>
                    const CupertinoActivityIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
              Text(
                group.name,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
