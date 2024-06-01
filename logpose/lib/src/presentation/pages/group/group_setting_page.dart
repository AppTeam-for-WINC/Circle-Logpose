import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/responsive_util.dart';
import '../../components/common/group_name_and_image_section.dart';

import '../../components/components/group/group_setting/group_setting_save_button.dart';
import '../../components/components/group/group_setting/sections/member_section/group_setting_member_section.dart';
import '../../components/components/group/group_setting/sections/schedule_section/group_setting_schedule_section.dart';
import '../../components/components/navigation_bar/group_setting_navigation/group_setting_navigation_bar.dart';

import '../../notifiers/group_setting_notifier_provider.dart';

import '../../providers/error_message/group_name_error_msg_provider.dart';
// import '../../../common/progress/progress_indicator.dart';

class GroupSettingPage extends ConsumerStatefulWidget {
  const GroupSettingPage({super.key, required this.groupId});

  final String groupId;

  @override
  ConsumerState<GroupSettingPage> createState() => _GroupSettingPageState();
}

class _GroupSettingPageState extends ConsumerState<GroupSettingPage> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    // final loadingErrorMessage = ref.watch(loadingErrorMessageProvider);

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
      containerMarginTop: deviceHeight * 0.05,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerMarginTop: deviceHeight * 0.05,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      containerMarginTop: deviceHeight * 0.05,
    );
  }

  Widget _buildLayout({
    required double containerMarginTop,
  }) {
    final groupId = widget.groupId;
    final groupProfile = ref.watch(groupSettingNotifierProvider(groupId));
    if (groupProfile == null) {
      return const SizedBox.shrink();
    }

    final groupNameErrorMessage = ref.watch(groupNameErrorMessageProvider);

    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 246),
      navigationBar: GroupSettingNavigationBar(groupId: groupId),
      child: SingleChildScrollView(
        child: Container(
          alignment: AlignmentDirectional.center,
          margin: EdgeInsets.only(top: containerMarginTop),
          child: Column(
            children: [
              GroupNameAndImageSection(
                loadingErrorMessage: groupNameErrorMessage,
                imagePath: groupProfile.image,
                groupName: groupProfile.name,
              ),
              const SizedBox(height: 10),
              GroupSettingMemberSection(groupId: groupId),
              const SizedBox(height: 20),
              GroupSettingScheduleSection(
                groupId: groupId,
                groupName: groupProfile.name,
              ),
              const SizedBox(height: 20),
              GroupSettingSaveButton(
                groupId: groupId,
                groupName: groupProfile.name,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
