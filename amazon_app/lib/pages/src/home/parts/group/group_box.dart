import 'package:amazon_app/pages/src/group/setting/group_setting_page.dart';
import 'package:amazon_app/pages/src/home/parts/group/controller/joined_group_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupBox extends ConsumerStatefulWidget {
  const GroupBox({super.key, required this.groupWithId});

  final GroupWithId groupWithId;
  @override
  ConsumerState createState() => GroupBoxState();
}

class GroupBoxState extends ConsumerState<GroupBox> {
  @override
  Widget build(BuildContext context) {
    final groupWithId = widget.groupWithId;
    final group = groupWithId.group;
    final groupId = groupWithId.groupId;

    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
            builder: (context) => GroupSettingPage(groupId: groupId),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(36),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: group.image,
              placeholder: (context, url) =>
                  const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageBuilder: (context, imageProvider) => Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            Expanded(
              child: Text(
                group.name,
                style: const TextStyle(
                  fontSize: 20,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
