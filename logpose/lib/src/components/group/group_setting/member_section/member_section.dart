import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controllers/providers/group/members/membership/set_group_member_list_provider.dart';
import '../../../image/custom_image.dart';
import 'components/group_member_image_list.dart';

class MemberSection extends ConsumerStatefulWidget {
  const MemberSection({super.key, required this.groupId});
  final String groupId;
  @override
  ConsumerState createState() => _MemberSectionState();
}

class _MemberSectionState extends ConsumerState<MemberSection> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final groupId = widget.groupId;

    return Container(
      width: deviceWidth * 0.85,
      height: deviceHeight * 0.08,
      margin: const EdgeInsets.only(top: 10, left: 6),
      padding: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 3),
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'メンバー',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF9A9A9A),
              ),
            ),
            ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: 0.8,
                child: SizedBox(
                  child: Row(
                    children: [
                      GroupMemberImageList(role: 'admin', groupId: groupId),
                      GroupMemberImageList(
                        role: 'membership',
                        groupId: groupId,
                      ),
                      // Set user's image list.
                      ...ref.watch(setGroupMemberListProvider).map(
                            (memberProfile) => CustomImage(
                              imagePath: memberProfile.image,
                              width: 30,
                              height: 30,
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
