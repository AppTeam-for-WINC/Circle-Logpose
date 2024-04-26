import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/database/user/user.dart';

class GroupMemberImage extends ConsumerStatefulWidget {
  const GroupMemberImage({
    super.key,
    required this.userProfile,
  });
  final UserProfile userProfile;

  @override
  ConsumerState<GroupMemberImage> createState() => _GroupMemberImageState();
}

class _GroupMemberImageState extends ConsumerState<GroupMemberImage> {
  @override
  Widget build(BuildContext context) {
    final userProfile = widget.userProfile;

    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: userProfile.image.startsWith('http')
              ? NetworkImage(
                  userProfile.image,
                )
              : AssetImage(
                  userProfile.image,
                ) as ImageProvider,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
