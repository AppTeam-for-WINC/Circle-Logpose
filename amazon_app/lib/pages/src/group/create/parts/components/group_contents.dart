import 'dart:io';
import 'package:amazon_app/controller/entities/device/image_controller.dart';

import 'package:amazon_app/pages/src/group/create/group_create_controller.dart';
import 'package:amazon_app/pages/src/group/create/parts/admin/group_admin.dart';
import 'package:amazon_app/pages/src/group/create/parts/components/group_contents_controller.dart';
import 'package:amazon_app/pages/src/group/create/parts/membership/group_member.dart';
import 'package:amazon_app/pages/src/group/create/parts/membership/group_member_controller.dart';
import 'package:amazon_app/pages/src/home/home_page.dart';
import 'package:amazon_app/pages/src/popup/member_add/member_add.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class GroupContents extends ConsumerStatefulWidget {
  const GroupContents({super.key});
  @override
  ConsumerState<GroupContents> createState() => GroupContentsState();
}

class GroupContentsState extends ConsumerState<GroupContents> {
  File? image;

  ///画像を選択する関数。
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
    final groupAdminMemberProfile = ref.watch(groupAdminMemberProfileProvider);
    final groupAddData = ref.watch(groupAddMemberDataProvider.notifier);
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFFF5F3FE),
      child: Stack(
        children: [
          Positioned(
            top: deviceHeight * 0.12,
            left: deviceWidth * 0.1,
            child: Container(
              //中央トピック
              width: 350,
              height: 210,
              margin: const EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(225, 127, 145, 145),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 20, 60, 10),
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
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 1), // 影のオフセット
                                    ),
                                  ],
                                ),
                              ),
                        const Icon(
                          Icons.arrow_forward,
                          size: 30,
                          color: Colors.grey,
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
                  Container(
                    width: 272,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 244, 253, 194),
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 2,
                          offset: Offset(0, 3),
                          color: Color.fromARGB(225, 127, 145, 145),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: CupertinoTextField(
                        controller: groupAddData.groupNameController,
                        prefix: const Icon(Icons.add),
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
            left: deviceWidth * 0.1,
            child: Container(
              width: 350,
              height: 400,
              margin: const EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(225, 147, 145, 145),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3),
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
                  Expanded(
                    child: SingleChildScrollView(
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
                            //追加したユーザーを表示しています。
                            ...ref.watch(groupMemberListProvider).map(
                                  (member) => GroupMember(userProfile: member),
                                ),
                          ],
                        ),
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
                onPressed: () async {
                  final success = await CreateGroupController.createGroup(
                    groupAddData.groupNameController.text,
                    image,
                    '',
                    ref,
                  );
                  if (!success) {
                    return;
                  }
                  if (!mounted) {
                    return;
                  }

                  //init group name.
                  groupAddData.groupNameController.clear();

                  //init group member list.
                  ref.watch(groupMemberListProvider.notifier).resetMemberList();

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
                Icons.person_remove,
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
            top: deviceHeight * 0.5,
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
              onPressed: () async {},
            ),
          ),
        ],
      ),
    );
  }
}
