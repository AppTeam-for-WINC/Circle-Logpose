import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/database/user/user.dart';
import '../../image/custom_cached_network_image.dart';
import '../../text/custom_text.dart';

class GroupAdminMemberTile extends ConsumerWidget {
  const GroupAdminMemberTile({super.key, required this.adminUserProfile});
  final UserProfile adminUserProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(40),
        color: const Color.fromARGB(255, 233, 200, 248),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 3),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 10),
              child: CustomCachedNetworkImage(
                imagePath: adminUserProfile.image,
                width: 37,
                height: 37,
              ),
            ),
            CustomText(text: adminUserProfile.name),
          ],
        ),
      ),
    );
  }
}
