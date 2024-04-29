import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/providers/group/mode/group_member_delete_mode_provider.dart';
import '../../../models/database/user/user.dart';
import '../../image/custom_cached_network_image.dart';
import '../../text/custom_text.dart';
import 'components/member_delete_button.dart';

class GroupMembershipTile extends ConsumerStatefulWidget {
  const GroupMembershipTile({super.key, required this.userProfile});
  final UserProfile userProfile;
  @override
  ConsumerState<GroupMembershipTile> createState() => _GroupMemberState();
}

class _GroupMemberState extends ConsumerState<GroupMembershipTile> {
  @override
  Widget build(BuildContext context) {
    final userProfile = widget.userProfile;
    return Stack(
      children: [
        SizedBox.expand(
          child: DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 2,
                  offset: Offset(1, 1),
                ),
              ],
              borderRadius: BorderRadius.circular(40),
              color: const Color.fromARGB(255, 248, 233, 255),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    child: CustomCachedNetworkImage(
                      imagePath: userProfile.image,
                      width: 37,
                      height: 37,
                    ),
                  ),
                  CustomText(text: userProfile.name),
                ],
              ),
            ),
          ),
        ),
        if (ref.watch(groupMemberDeleteModeProvider))
          Positioned(
            top: 0,
            right: 0,
            child: MemberDeleteButton(accountId: userProfile.accountId),
          ),
      ],
    );
  }
}
