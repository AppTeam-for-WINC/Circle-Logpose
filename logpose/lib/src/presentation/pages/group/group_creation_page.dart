import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/responsive_util.dart';

import '../../components/common/loading_progress.dart';
import '../../components/common/member_switch/member_addition_switch.dart';
import '../../components/common/member_switch/member_deletion_switch.dart';
import '../../components/common/name_and_image_setting_section.dart';
import '../../components/common/progress_indicator.dart';

import '../../components/components/group/group_creation/group_creation_button.dart';
import '../../components/components/group/group_creation/member_section/group_creation_member_section.dart';

class GroupCreationPage extends ConsumerStatefulWidget {
  const GroupCreationPage({super.key});
  @override
  ConsumerState<GroupCreationPage> createState() => _GroupCreationPageState();
}

class _GroupCreationPageState extends ConsumerState<GroupCreationPage> {
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
      deviceWidth: deviceWidth,
      groupNameAndImageSectionPositionTop: deviceHeight * 0.176,
      groupCreationMemberSectionTop: deviceHeight * 0.38,
      creationButtonPositionTop: deviceHeight * 0.86,
      additionSwitchPositionTop: deviceHeight * 0.45,
      additionSwitchPositionLeft: deviceWidth * 0.84,
      deletionSwitchPositionTop: deviceHeight * 0.51,
      deletionSwitchPositionLeft: deviceWidth * 0.84,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      deviceWidth: deviceWidth,
      groupNameAndImageSectionPositionTop: deviceHeight * 0.176,
      groupCreationMemberSectionTop: deviceHeight * 0.38,
      creationButtonPositionTop: deviceHeight * 0.86,
      additionSwitchPositionTop: deviceHeight * 0.45,
      additionSwitchPositionLeft: deviceWidth * 0.88,
      deletionSwitchPositionTop: deviceHeight * 0.505,
      deletionSwitchPositionLeft: deviceWidth * 0.88,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      deviceWidth: deviceWidth,
      groupNameAndImageSectionPositionTop: deviceHeight * 0.176,
      groupCreationMemberSectionTop: deviceHeight * 0.38,
      creationButtonPositionTop: deviceHeight * 0.86,
      additionSwitchPositionTop: deviceHeight * 0.45,
      additionSwitchPositionLeft: deviceWidth * 0.89,
      deletionSwitchPositionTop: deviceHeight * 0.505,
      deletionSwitchPositionLeft: deviceWidth * 0.89,
    );
  }

  Widget _buildLayout({
    required double deviceWidth,
    required double groupNameAndImageSectionPositionTop,
    required double groupCreationMemberSectionTop,
    required double creationButtonPositionTop,
    required double additionSwitchPositionTop,
    required double additionSwitchPositionLeft,
    required double deletionSwitchPositionTop,
    required double deletionSwitchPositionLeft,
  }) {
    final loadingErrorMessage = ref.watch(loadingErrorMessageProvider);

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF5F3FE),
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: groupNameAndImageSectionPositionTop,
              child: NameAndImageSettingSection(
                loadingErrorMessage: loadingErrorMessage,
                placeholder: 'group name',
              ),
            ),
            Positioned(
              top: groupCreationMemberSectionTop,
              child: const GroupCreationMemberSection(),
            ),
            Positioned(
              top: creationButtonPositionTop,
              child: const GroupCreationButton(),
            ),
            Positioned(
              top: additionSwitchPositionTop,
              left: additionSwitchPositionLeft,
              child: const MemberAdditionSwitch(),
            ),
            Positioned(
              top: deletionSwitchPositionTop,
              left: deletionSwitchPositionLeft,
              child: const MemberDeletionSwitch(
                type: GroupManagementType.create,
              ),
            ),
            const PageProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
