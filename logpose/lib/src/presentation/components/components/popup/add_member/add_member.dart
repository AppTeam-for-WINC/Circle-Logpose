import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/invitation_link/copy_invitation_link_button.dart';
import 'components/search_field/user_profile_search_field.dart';
import 'components/user_profile/user_profile_button.dart';

class AddMember extends ConsumerStatefulWidget {
  const AddMember({super.key, required this.groupId});
  final String? groupId;

  @override
  ConsumerState<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends ConsumerState<AddMember> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final groupId = widget.groupId;

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: SizedBox(
          width: deviceWidth * 0.8,
          height: deviceHeight * 0.35,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFF5F3FE),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40,
              ),
              child: Column(
                children: [
                  UserProfileSearchField(groupId: groupId),
                  UserProfileButton(groupId: groupId),
                  if (groupId != null)
                    CopyInvitationLinkButton(groupId: groupId),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
