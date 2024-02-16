import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../group/setting/group_setting_page.dart';
import 'controller/joined_group_controller.dart';

class GroupBox extends ConsumerStatefulWidget {
  const GroupBox({super.key, required this.groupId});

  final String groupId;
  @override
  ConsumerState createState() => GroupBoxState();
}

class GroupBoxState extends ConsumerState<GroupBox> {
  @override
  Widget build(BuildContext context) {
    final groupId = widget.groupId;
    final asyncGroupProfileList = ref.watch(readGroupWithIdProvider(groupId));

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
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0, 2),
              color: Color.fromRGBO(0, 0, 0, 0.15),
            ),
          ],
        ),
        child: asyncGroupProfileList.when(
          data: (groupData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: groupData.groupProfile.image,
                  placeholder: (context, url) => const SizedBox.shrink(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageBuilder: (context, imageProvider) => Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    groupData.groupProfile.name,
                    style: const TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ],
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (error, stack) => Text('$error'),
        ),
      ),
    );
  }
}
