import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupMemberImage extends ConsumerStatefulWidget {
  const GroupMemberImage({
    super.key,
    required this.imagePath,
  });
  final String imagePath;

  @override
  ConsumerState<GroupMemberImage> createState() => _GroupMemberImageState();
}

class _GroupMemberImageState extends ConsumerState<GroupMemberImage> {
  @override
  Widget build(BuildContext context) {
    final imagePath = widget.imagePath;

    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imagePath.startsWith('http')
              ? NetworkImage(
                  imagePath,
                )
              : AssetImage(
                  imagePath,
                ) as ImageProvider,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
