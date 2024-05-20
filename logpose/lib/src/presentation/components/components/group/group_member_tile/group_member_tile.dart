import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../../domain/entity/user_profile.dart';

import '../../../../../domain/providers/group/mode/group_member_delete_mode_provider.dart';

import '../../../common/custom_image/custom_cached_network_image.dart';
import '../../../common/custom_text.dart';

import 'components/member_delete_button.dart';

class GroupMemberTile extends ConsumerStatefulWidget {
  const GroupMemberTile({
    super.key,
    required this.memberProfile,
    required this.adminOrMembership,
    this.groupId,
  });
  final UserProfile memberProfile;
  final String adminOrMembership;
  final String? groupId;

  @override
  ConsumerState<GroupMemberTile> createState() => _GroupMemberTileState();
}

class _GroupMemberTileState extends ConsumerState<GroupMemberTile> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final memberProfile = widget.memberProfile;
    final adminOrMembership = widget.adminOrMembership;

    if (adminOrMembership == 'admin') {
      return _MemberNameAndImageView(memberProfile: memberProfile);
    } else if (adminOrMembership == 'membership') {
      return SizedBox(
        height: deviceHeight * 0.06,
        child: Stack(
          children: [
            Positioned.fill(
              child: _MemberNameAndImageView(memberProfile: memberProfile),
            ),
            if (ref.watch(groupMemberDeleteModeProvider))
              Positioned(
                top: 0,
                right: 0,
                child: MemberDeleteButton(
                  accountId: memberProfile.accountId,
                  groupId: widget.groupId,
                ),
              ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _MemberNameAndImageView extends ConsumerWidget {
  const _MemberNameAndImageView({required this.memberProfile});
  final UserProfile memberProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 0.5,
            spreadRadius: 0.1,
            offset: Offset(1, 1),
            color: CupertinoColors.systemGrey,
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
                imagePath: memberProfile.image,
                width: 37,
                height: 37,
              ),
            ),
            CustomText(text: memberProfile.name),
          ],
        ),
      ),
    );
  }
}
