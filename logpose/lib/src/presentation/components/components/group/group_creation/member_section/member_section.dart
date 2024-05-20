import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/member_section_label.dart';
import 'components/member_section_member_list.dart';

class MemberSection extends ConsumerStatefulWidget {
  const MemberSection({super.key});

  @override
  ConsumerState createState() => _MemberSectionState();
}

class _MemberSectionState extends ConsumerState<MemberSection> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: deviceWidth * 0.85,
      height: deviceHeight * 0.41,
      margin: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: CupertinoColors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 2.2,
            spreadRadius: 2.2,
            offset: Offset(0, 3),
            color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MemberSectionLabel(),
          MemberSectionMemberList(),
        ],
      ),
    );
  }
}
