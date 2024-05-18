import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/providers/error_message/update_user_profile_error_provider.dart';
import '../../../domain/providers/user/set_user_profile_provider.dart';

import '../../components/common/photo_button.dart';
import '../../components/common/red_error_message.dart';
import '../../components/components/navigation_bar/user_setting_navigation_bar.dart';
import '../../components/components/text_field/name_field.dart';
import '../../components/components/user_setting/save_button.dart';
import '../../components/components/user_setting/sections/account_id_section.dart';
import '../../components/components/user_setting/sections/email_section.dart';
import '../../components/components/user_setting/sections/group_section.dart';
import '../../components/components/user_setting/sections/password_section.dart';
import '../../components/components/user_setting/user_image_view.dart';

// import '../../common/progress/progress_indicator.dart';

class UserSettingPage extends ConsumerStatefulWidget {
  const UserSettingPage({super.key});
  @override
  ConsumerState<UserSettingPage> createState() => _UserSettingPageState();
}

class _UserSettingPageState extends ConsumerState<UserSettingPage> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final userProfileError = ref.watch(updateUserProfileErrorMessageProvider);
    // final loadingErrorMessage = ref.watch(loadingErrorMessageProvider);

    final userProfile = ref.watch(setUserProfileDataProvider);
    if (userProfile == null) {
      return const SizedBox.shrink();
    }

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF5F3FE),
      navigationBar: UserSettingNavigationBar(
        context: context,
        ref: ref,
        mounted: mounted,
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: deviceWidth * 0.85,
                height: deviceHeight * 0.215,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFD9D9D9),
                      offset: Offset(1, 3),
                      blurRadius: 3,
                      spreadRadius: 1,
                    ),
                  ],
                  color: CupertinoColors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                  border: Border.all(color: const Color(0xFFD9D9D9)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(60, 0, 60, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          UserImageView(imagePath: userProfile.image),
                          const Icon(
                            CupertinoIcons.arrow_right_arrow_left,
                            size: 30,
                            color: CupertinoColors.systemGrey,
                          ),
                          const PhotoButton(),
                        ],
                      ),
                    ),
                    if (userProfileError != null)
                      RedErrorMessage(
                        errorMessage: userProfileError,
                        fontSize: 14,
                      ),
                    NameField(placeholder: 'username', name: userProfile.name),
                  ],
                ),
              ),
              const AccountIdSection(),
              const EmailSection(),
              const PasswordSection(),
              const GroupSection(),
              SaveButton(name: userProfile.name),
              // const PageProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
