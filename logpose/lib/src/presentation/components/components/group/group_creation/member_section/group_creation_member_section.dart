import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../utils/responsive_util.dart';

import 'components/group_creation_member_section_label.dart';
import 'components/group_creation_member_section_member_list.dart';

class GroupCreationMemberSection extends ConsumerStatefulWidget {
  const GroupCreationMemberSection({super.key});

  @override
  ConsumerState createState() => _GroupCreationMemberSectionState();
}

class _GroupCreationMemberSectionState
    extends ConsumerState<GroupCreationMemberSection> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtil.isMobile(context)) {
          return _buildMobileLayout(deviceWidth, deviceHeight);
        } else if (ResponsiveUtil.isTablet(context)) {
          return _buildTabletLayout(deviceWidth, deviceHeight);
        } else {
          return _buildDesktopLayout(deviceWidth, deviceHeight);
        }
      },
    );
  }

  Widget _buildMobileLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.85,
      containerHeight: deviceHeight * 0.41,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.85,
      containerHeight: deviceHeight * 0.41,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerWidth: deviceWidth * 0.85,
      containerHeight: deviceHeight * 0.41,
    );
  }

  Widget _buildLayout({
    required double containerWidth,
    required double containerHeight,
  }) {
    return Container(
      width: containerWidth,
      height: containerHeight,
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
          GroupCreationMemberSectionLabel(),
          GroupCreationMemberSectionMemberList(),
        ],
      ),
    );
  }
}
