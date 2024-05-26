import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/member_list_delete_section.dart';

class MemberListDelete extends ConsumerStatefulWidget {
  const MemberListDelete({super.key, required this.groupId});
  final String groupId;

  @override
  ConsumerState<MemberListDelete> createState() => _MemberListDeleteState();
}

class _MemberListDeleteState extends ConsumerState<MemberListDelete> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final groupId = widget.groupId;

    return Stack(
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: SizedBox(
              width: deviceWidth * 0.8,
              height: deviceHeight * 0.55,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color(0xFFF5F3FE),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: MemberListDeleteSection(groupId: groupId),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
