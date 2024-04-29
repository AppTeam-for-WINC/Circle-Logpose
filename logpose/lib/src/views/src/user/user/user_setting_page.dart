import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/loading_progress.dart';
import '../../../../components/slide/slider/schedule_list_and_joined_group_tab_slider.dart';
import '../../../../components/user/user_joined_group_tile.dart';

import '../../../../controllers/controllers/user/update_user_profile.dart';
import '../../../../controllers/providers/error/update_user_profile_error_provider.dart';
import '../../../../controllers/providers/group/group/watch_joined_group_profile_provider.dart';
import '../../../../controllers/providers/user/set_user_profile_provider.dart';

import '../../../../entities/device/image_controller.dart';
import '../../../../services/auth/auth_controller.dart';
// import '../../common/progress/progress_indicator.dart';

import '../../start/start_page.dart';
import '../account_id/account_id_setting_page.dart';
import '../email/email_setting_page.dart';
import '../password/password_setting_page.dart';

class UserSettingPage extends ConsumerStatefulWidget {
  const UserSettingPage({super.key});
  @override
  ConsumerState<UserSettingPage> createState() => _UserSettingPageState();
}

class _UserSettingPageState extends ConsumerState<UserSettingPage> {
  File? image;

  ///Select image.
  Future<String> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return 'no image';
      }
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);

      return 'Success: selected image.';
    } on PlatformException catch (e) {
      debugPrint('Failed: $e');
      return 'Failed';
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final imageIconSize = deviceWidth * 0.15;

    // final userProfileError = 
    // ref.watch(updateUserProfileErrorMessageProvider);
    final isLoading = ref.watch(loadingProgressProvider);
    // final loadingErrorMessage = ref.watch(loadingErrorMessageProvider);
    final groupsProfile = ref.watch(watchJoinedGroupsProfileProvider);
    final userProfile = ref.watch(setUserProfileDataProvider);
    final userProfileNotifier = ref.watch(setUserProfileDataProvider.notifier);

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF5F3FE),
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          onPressed: () async {
            // Init
            await userProfileNotifier.readUserData();

            if (!mounted) {
              return;
            }
            await Navigator.push(
              context,
              CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                builder: (context) => 
                const ScheduleListAndJoinedGroupTabSlider(),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFF5F3FE),
        border: const Border(bottom: BorderSide(color: Colors.transparent)),
        middle: Container(
          width: 178,
          height: 38,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFD9D9D9),
                offset: Offset(0, 2),
                blurRadius: 2,
                spreadRadius: 1,
              ),
            ],
            color: const Color(0xFF7B61FF),
            borderRadius: BorderRadius.circular(80),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.manage_accounts,
                color: Colors.white,
              ),
              Text(
                'ユーザー設定',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        trailing: CupertinoButton(
          onPressed: () async {
            await showCupertinoModalPopup<void>(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: const Text('ログアウトしますか?'),
                  actions: <CupertinoDialogAction>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No'),
                    ),
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () async {
                        await AuthController.logout();
                        if (!mounted) {
                          return;
                        }
                        await Navigator.push(
                          context,
                          CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                            builder: (context) => const StartPage(),
                          ),
                        );
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(
            Icons.logout,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                width: deviceWidth * 0.88,
                height: deviceHeight * 0.21,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFD9D9D9),
                      offset: Offset(1, 3),
                      blurRadius: 3,
                      spreadRadius: 1,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                  border: Border.all(
                    color: const Color(0xFFD9D9D9),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (userProfile?.image != null)
                          Container(
                            width: deviceWidth * 0.17,
                            height: deviceHeight * 0.0765,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: userProfile!.image.startsWith('http')
                                    ? NetworkImage(userProfile.image)
                                    : AssetImage(userProfile.image)
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          )
                        else
                          const Icon(
                            Icons.face,
                            size: 50,
                            color: Colors.grey,
                          ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: const Icon(
                            Icons.cached_sharp,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                        CupertinoButton(
                          onPressed: () async {
                            final imageGetResult = await pickImage();
                            if (imageGetResult == 'Failed') {
                              if (!mounted) {
                                return;
                              }
                              await showPhotoAccessDeniedDialog(context);
                            }
                            if (image != null) {
                              userProfileNotifier.setNewImage(image!);
                            }
                          },
                          child: SizedBox(
                            child: Icon(
                              Icons.image,
                              size: imageIconSize,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Username
                    Container(
                      width: deviceWidth * 0.65,
                      height: deviceHeight * 0.05,
                      margin: const EdgeInsets.only(
                        top: 5,
                        bottom: 20,
                      ),
                      padding: const EdgeInsets.only(left: 3),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFD9D9D9),
                            offset: Offset(0, 2),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                        ],
                        color: const Color.fromARGB(255, 244, 219, 251),
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: CupertinoTextField(
                        controller: userProfileNotifier.nameController,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          backgroundBlendMode: BlendMode.dstIn,
                        ),
                        prefix: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.create_sharp,
                            color: Colors.black,
                          ),
                        ),
                        placeholder: 'username',
                      ),
                    ),
                  ],
                ),
              ),
              // Account ID
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: deviceWidth * 0.88,
                height: deviceHeight * 0.06,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFD9D9D9),
                      offset: Offset(1, 3),
                      blurRadius: 3,
                      spreadRadius: 1,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                  border: Border.all(
                    color: const Color(0xFFD9D9D9),
                  ),
                ),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    await Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                        builder: (context) => const AccountIdSettingPage(),
                      ),
                      (_) => false,
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.black,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Account ID',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //Email
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: deviceWidth * 0.88,
                height: deviceHeight * 0.06,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFD9D9D9),
                      offset: Offset(1, 3),
                      blurRadius: 3,
                      spreadRadius: 1,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                  border: Border.all(
                    color: const Color(0xFFD9D9D9),
                  ),
                ),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    await Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                        builder: (context) => const EmailSettingPage(),
                      ),
                      (_) => false,
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(
                              Icons.mail_outline,
                              color: Colors.black,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'メールアドレス',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: deviceWidth * 0.88,
                height: deviceHeight * 0.06,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFD9D9D9),
                      offset: Offset(1, 3),
                      blurRadius: 3,
                      spreadRadius: 1,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                  border: Border.all(
                    color: const Color(0xFFD9D9D9),
                  ),
                ),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    await Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                        builder: (context) => const PasswordSettingPage(),
                      ),
                      (_) => false,
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(
                              Icons.key,
                              color: Colors.black,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'パスワード',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: deviceWidth * 0.88,
                height: deviceHeight * 0.24,
                margin: const EdgeInsets.only(top: 10),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15, top: 15),
                        child: Row(
                          children: [
                            Text('所属団体'),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          width: deviceWidth * 0.86,
                          height: deviceHeight * 0.19,
                          padding: const EdgeInsets.only(
                            top: 5,
                            right: 5,
                            left: 5,
                            bottom: 5,
                          ),
                          child: GridView.count(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            childAspectRatio: 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            children: groupsProfile.when(
                              data: (groupProfile) {
                                if (groupProfile.isEmpty) {
                                  return const [SizedBox.shrink()];
                                }
                                return groupProfile.map((groupId) {
                                  return UserJoinedGroupTile(
                                    groupId: groupId,
                                  );
                                }).toList();
                              },
                              loading: () => const [SizedBox.shrink()],
                              error: (error, stack) => [Text('$error')],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: CupertinoButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          LoadingProgressController.loadingProgress(
                            ref,
                            loading: true,
                          );

                          final errorMessage = await UpdateUserProfile.update(
                            userProfileNotifier.nameController.text,
                            image,
                            null,
                            ref,
                          );
                          if (errorMessage != null) {
                            ref
                                .watch(
                                  updateUserProfileErrorMessageProvider
                                      .notifier,
                                )
                                .state = errorMessage;
                            return;
                          }

                          if (!mounted) {
                            return;
                          }

                          LoadingProgressController.loadingProgress(
                            ref,
                            loading: false,
                          );

                          await Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                              builder: (context) => 
                              const ScheduleListAndJoinedGroupTabSlider(),
                            ),
                            (_) => false,
                          );
                        },
                  color: const Color(0xFF7B61FF),
                  borderRadius: BorderRadius.circular(30),
                  child: SizedBox(
                    width: 117,
                    child: Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.download,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('変更を保存'),
                      ],
                    ),
                  ),
                ),
              ),
              // const PageProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
