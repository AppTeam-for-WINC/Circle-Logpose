import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/group_image_view.dart';
import '../../../common/loading_progress.dart';

import '../../../common/photo_button.dart';
import '../../../common/red_error_message.dart';
import '../../../components/group/group_creation/create_group_button/create_group_button.dart';
import '../../../components/group/group_creation/group_member_section/member_section.dart';
import '../../../components/group/switch/add_member_switch.dart';
import '../../../components/group/switch/delete_member_switch.dart';
import '../../../components/progress/progress_indicator.dart';
import '../../../components/text_field/name_field.dart';

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
    final loadingErrorMessage = ref.watch(loadingErrorMessageProvider);

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF5F3FE),
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: deviceHeight * 0.176,
              child: Container(
                width: deviceWidth * 0.85,
                height: deviceHeight * 0.215,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: CupertinoColors.white,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 2,
                      offset: Offset(0, 2),
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 60,
                        right: 60,
                        bottom: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GroupImageView(),
                          Icon(
                            CupertinoIcons.arrow_right_arrow_left,
                            size: 30,
                            color: CupertinoColors.systemGrey,
                          ),
                          PhotoButton(),
                        ],
                      ),
                    ),
                    if (loadingErrorMessage != null)
                      RedErrorMessage(
                        errorMessage: loadingErrorMessage,
                        fontSize: 14,
                      ),
                    const NameField(placeholder: '団体名'),
                  ],
                ),
              ),
            ),
            Positioned(
              top: deviceHeight * 0.38,
              child: const MemberSection(),
            ),
            Positioned(
              top: deviceHeight * 0.86,
              left: deviceWidth * 0.26,
              child: const CreateGroupButton(),
            ),
            Positioned(
              top: deviceHeight * 0.45,
              left: deviceWidth * 0.84,
              child: const AddMemberSwitch(),
            ),
            Positioned(
              top: deviceHeight * 0.505,
              left: deviceWidth * 0.84,
              child: const DeleteMemberSwitch(mode: 'create'),
            ),
            const PageProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
