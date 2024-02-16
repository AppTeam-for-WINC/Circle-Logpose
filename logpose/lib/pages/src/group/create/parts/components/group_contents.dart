import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../controller/common/loading_progress.dart';
import '../../../../../../controller/entities/device/image_controller.dart';
import '../../../../../common/progress/progress_indicator.dart';
import '../../../../home/home_page.dart';
import '../../../../popup/member_add/member_add.dart';
import '../../group_create_controller.dart';
import '../admin/group_admin.dart';
import '../membership/group_member.dart';
import 'group_contents_controller.dart';
import 'set_member_controller.dart';

class GroupCreateContents extends ConsumerStatefulWidget {
  const GroupCreateContents({super.key});
  @override
  ConsumerState<GroupCreateContents> createState() =>
      _GroupCreateContentsState();
}

class _GroupCreateContentsState extends ConsumerState<GroupCreateContents> {
  File? image;

  /// Select image.
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
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final isLoading = ref.watch(loadingProgressProvider);
    final loadingErrorMessage = ref.watch(loadingErrorMessageProvider);

    final groupAdminMemberProfile = ref.watch(groupAdminMemberProfileProvider);
    final groupAddData = ref.watch(groupAddMemberDataProvider.notifier);

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
                  color: Colors.white,
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
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 60,
                        right: 60,
                        bottom: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          image == null
                              ? const Icon(
                                  Icons.group,
                                  size: 70,
                                  color: Colors.grey,
                                )
                              : Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(image!),
                                      fit: BoxFit.cover, // 画像のフィットを指定
                                    ),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                          const Icon(
                            Icons.cached_sharp,
                            size: 30,
                            color: Colors.grey,
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              final imageGetResult = await pickImage();
                              if (imageGetResult == 'Failed') {
                                if (!mounted) {
                                  return;
                                }
                                await showPhotoAccessDeniedDialog(context);
                              }
                            },
                            child: const SizedBox(
                              child: Icon(
                                Icons.image,
                                size: 70,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Error message.
                    if (loadingErrorMessage != null)
                      Text(
                        loadingErrorMessage,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),

                    Container(
                      width: deviceWidth * 0.65,
                      height: deviceHeight * 0.05,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 244, 219, 251),
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 2.5,
                            spreadRadius: 2.5,
                            offset: Offset(0, 2),
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: CupertinoTextField(
                          controller: groupAddData.groupNameController,
                          prefix: const Icon(
                            Icons.create_sharp,
                          ),
                          style: const TextStyle(fontSize: 18),
                          placeholder: '団体名',
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: deviceHeight * 0.38,
              child: Container(
                width: deviceWidth * 0.85,
                height: deviceHeight * 0.41,
                margin: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 2.2,
                      spreadRadius: 2.2,
                      offset: Offset(0, 3),
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 30,
                        bottom: 10,
                      ),
                      child: const Text(
                        'メンバー',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Center(
                        child: GridView.count(
                          crossAxisSpacing: 26,
                          mainAxisSpacing: 14,
                          childAspectRatio: 2.5,
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10),
                          children: <Widget>[
                            groupAdminMemberProfile.when(
                              data: (adminUserProfile) {
                                return GroupAdminMember(
                                  adminUserProfile: adminUserProfile,
                                );
                              },
                              loading: () => const SizedBox.shrink(),
                              error: (error, stack) => Text('$error'),
                            ),

                            // Set user list.
                            ...ref.watch(setGroupMemberListProvider).map(
                                  (member) =>
                                      SetGroupMember(userProfile: member),
                                ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: deviceHeight * 0.86,
              left: deviceWidth * 0.26,
              child: Container(
                margin: const EdgeInsets.only(top: 25),
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  color: const Color.fromARGB(255, 107, 88, 252),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(225, 127, 145, 145),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          LoadingProgressController.loadingProgress(
                            ref,
                            loading: true,
                          );

                          final errorMessage = await CreateGroup.createGroup(
                            groupAddData.groupNameController.text,
                            image,
                            null,
                            ref,
                          );

                          LoadingProgressController.loadingProgress(
                            ref,
                            loading: false,
                          );

                          if (errorMessage != null) {
                            LoadingProgressController.loadingErrorMessage(
                              ref,
                              errorMessage,
                            );
                            return;
                          }
                          if (!mounted) {
                            return;
                          }

                          await Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                              builder: (context) {
                                return const HomePage();
                              },
                            ),
                            (_) => false,
                          );
                        },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.white,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 25,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        '団体を作成',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: deviceHeight * 0.45,
              left: deviceWidth * 0.84,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    const CircleBorder(),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFD8EB61)),
                ),
                child: const Icon(
                  Icons.person_add,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () async {
                  await showCupertinoModalPopup<AddMember>(
                    context: context,
                    builder: (BuildContext context) {
                      return const Center(
                        child: AddMember(
                          groupId: null,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Positioned(
              top: deviceHeight * 0.505,
              left: deviceWidth * 0.84,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    const CircleBorder(),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFEB6161)),
                ),
                child: const Icon(
                  Icons.person_remove,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () async {
                  ref.watch(setMemberDeleteModeProvider.notifier).state =
                      !ref.watch(setMemberDeleteModeProvider);
                },
              ),
            ),
            const PageProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
