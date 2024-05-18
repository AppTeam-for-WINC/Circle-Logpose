import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/providers/error_message/group_name_error_msg_provider.dart';
import '../../../../domain/providers/group/group/group_setting_notifier_provider.dart';

import '../../../components/common/group_image_view.dart';
import '../../../components/common/photo_button.dart';
import '../../../components/common/red_error_message.dart';

import '../../../components/components/group/group_setting/save/save_button.dart';
import '../../../components/components/group/group_setting/sections/member_section/member_section.dart';
import '../../../components/components/group/group_setting/sections/schedule_section/schedule_section.dart';
import '../../../components/components/group/switch/add_member_switch.dart';
import '../../../components/components/group/switch/delete_member_switch.dart';
import '../../../components/components/navigation_bar/group_setting_navigation_bar.dart';
import '../../../components/components/text_field/name_field.dart';

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
              Container(
                width: deviceWidth * 0.85,
                height: deviceHeight * 0.215,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: CupertinoColors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 3),
                      blurRadius: 3,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(60, 0, 60, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GroupImageView(imagePath: groupProfile.image),
                          const Icon(
                            CupertinoIcons.arrow_right_arrow_left,
                            size: 30,
                            color: CupertinoColors.systemGrey,
                          ),
                          const PhotoButton(),
                        ],
                      ),
                    ),
                    if (groupNameErrorMessage != null)
                      RedErrorMessage(
                        errorMessage: groupNameErrorMessage,
                        fontSize: 14,
                      ),
                    NameField(placeholder: '団体名', name: groupProfile.name),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: deviceWidth * 0.88,
                height: deviceHeight * 0.1,
                child: Stack(
                  children: [
                    MemberSection(groupId: groupId),
                    Positioned(
                      top: -15,
                      right: -15,
                      child: AddMemberSwitch(groupId: groupId),
                    ),
                    Positioned(
                      top: 25,
                      right: -15,
                      child: DeleteMemberSwitch(
                        groupId: groupId,
                        mode: 'setting',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              ScheduleSection(groupId: groupId, groupName: groupProfile.name),
              const SizedBox(
                height: 20,
              ),
              SaveButton(groupId: groupId, groupName: groupProfile.name),
            ],
          ),
        ),
      ),
    );
  }
}
