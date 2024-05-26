import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/providers/error_message/group_name_error_msg_provider.dart';

import '../../components/common/group_name_and_image_section.dart';
import '../../components/components/group/group_setting/group_setting_save_button.dart';
import '../../components/components/group/group_setting/sections/member_section/group_setting_member_section.dart';
import '../../components/components/group/group_setting/sections/schedule_section/group_setting_schedule_section.dart';
import '../../components/components/navigation_bar/group_setting_navigation/group_setting_navigation_bar.dart';

import '../../notifiers/group_setting_notifier_provider.dart';
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

    final groupId = widget.groupId;
    final groupProfile = ref.watch(groupSettingNotifierProvider(groupId));
    if (groupProfile == null) {
      return const SizedBox.shrink();
    }

    // final loadingErrorMessage = ref.watch(loadingErrorMessageProvider);
    final groupNameErrorMessage = ref.watch(groupNameErrorMessageProvider);

    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 246),
      navigationBar: GroupSettingNavigationBar(
        context: context,
        ref: ref,
        mounted: mounted,
        groupId: groupId,
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GroupNameAndImageSection(
                loadingErrorMessage: groupNameErrorMessage,
                imagePath: groupProfile.image,
                groupName: groupProfile.name,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: deviceWidth * 0.88,
                height: deviceHeight * 0.1,
                child: GroupSettingMemberSection(groupId: groupId),
              ),
              const SizedBox(height: 15),
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
