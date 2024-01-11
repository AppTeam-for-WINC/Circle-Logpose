import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '/pages/home/home_page.dart';
import 'parts/email/email_setting.dart';
import 'parts/password/password_setting.dart';

class AccountSettingPage extends ConsumerWidget {
  const AccountSettingPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CupertinoPageScaffold(
      child: AccountSettingScreen(),
    );
  }
}

class AccountSettingScreen extends ConsumerStatefulWidget {
  const AccountSettingScreen({super.key});
  @override
  ConsumerState<AccountSettingScreen> createState() => AccountSettingState();
}

class AccountSettingState extends ConsumerState<AccountSettingScreen> {
  File? image;

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      debugPrint('failed:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFFF5F3FE),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 55,
            ),
            child: Column(
              children: [
                //ユーザー設定(title)
                Container(
                  width: 178,
                  height: 38,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFD9D9D9),
                        offset: Offset(0, 2),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                    color: const Color(0xFFD8EB61),
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.manage_accounts,
                          color: Colors.grey,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: const Text('ユーザ設定'),
                        ),
                      ],
                    ),
                  ),
                ),
                //１個目の白い箱
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(top: 10),
                  width: 360,
                  height: 180,
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
                      //個人アイコン
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.face,
                            size: 70,
                            color: Colors.grey,
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            size: 30,
                            color: Colors.grey,
                          ),
                          CupertinoButton(
                            onPressed: () async {
                              await pickImage();
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
                      //ユーザーネーム変更
                      Container(
                        width: 178,
                        height: 38,
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
                          color: const Color.fromARGB(255, 231, 238, 189),
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: const CupertinoTextField(
                          //ここにユーザーネーム変更のbackendの処理を書いて下さい。
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 231, 238, 189),
                            backgroundBlendMode: BlendMode.dstIn,
                          ),
                          prefix: Icon(
                            CupertinoIcons.text_cursor,
                            color: Colors.black,
                          ),
                          placeholder: 'username',
                        ),
                      ),
                    ],
                  ),
                ),
                //メアド
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 323,
                  height: 46,
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
                    color: const Color.fromARGB(255, 231, 238, 189),
                    borderRadius: const BorderRadius.all(Radius.circular(60)),
                    border: Border.all(
                      color: const Color(0xFFD9D9D9),
                    ),
                  ),
                  child: CupertinoButton(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(
                            left: 10,
                          ),
                          width: 30,
                          height: 30,
                          child: const Icon(
                            Icons.mail_outline,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          height: 22,
                          width: 143,
                          margin: const EdgeInsets.only(
                            left: 10,
                            bottom: 3,
                          ),
                          child: const Text(
                            'メールアドレス',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          height: 12,
                          width: 7,
                          margin: const EdgeInsets.only(left: 100, bottom: 8),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                          builder: (context) => const EmailSettingPage(),
                        ),
                      );
                    },
                  ),
                ),
                //パスワード
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 323,
                  height: 46,
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
                    color: const Color.fromARGB(255, 231, 238, 189),
                    borderRadius: const BorderRadius.all(Radius.circular(60)),
                    border: Border.all(
                      color: const Color(0xFFD9D9D9),
                    ),
                  ),
                  child: CupertinoButton(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(
                            left: 10,
                          ),
                          width: 30,
                          height: 30,
                          child: const Icon(
                            Icons.mail_outline,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          height: 22,
                          width: 143,
                          margin: const EdgeInsets.only(
                            left: 10,
                            bottom: 3,
                          ),
                          child: const Text(
                            'パスワード',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          height: 12,
                          width: 7,
                          margin: const EdgeInsets.only(left: 100, bottom: 8),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                          builder: (context) => const PasswordSettingPage(),
                        ),
                      );
                    },
                  ),
                ),
                //最後の白い箱
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    width: 390,
                    child: Stack(
                      children: [
                        Container(
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
                          width: 374,
                          height: 220,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      '所属団体',
                                    ),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Container(
                                  width: 354,
                                  height: 180,
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    right: 5,
                                    left: 5,
                                    bottom: 5,
                                  ),
                                  child: GridView.builder(
                                    itemCount: 20,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return const GroupCard();
                                    },
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 3,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CupertinoButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                        builder: (context) => const HomePage(),
                      ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GroupCard extends ConsumerWidget {
  const GroupCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {},
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(
            216,
            235,
            97,
            0.29,
          ),
          borderRadius: BorderRadius.circular(80),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Icon(CupertinoIcons.group_solid, size: 25),
              Text(
                '団体名',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9A9A9A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GroupMemberIcons extends ConsumerWidget {
  // 参加メンバーのアイコンを取得するように変更してください
  const GroupMemberIcons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const maxIcons = 8;
    const memberIcon = Icons.perm_identity;
    List<Widget> iconWidgets = [];
    //↑今後完成させるときに自動的に消えるはず by ichiro

    num iconCount = 0;
    while (iconCount < maxIcons) {
      iconWidgets.add(
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: const Icon(
            memberIcon,
            size: 30,
          ),
        ),
      );
      iconCount++;
    }

    if (iconCount >= maxIcons) {
      iconWidgets.add(
        const Text(
          '…',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 30,
          ),
        ),
      );
    }

    return Row(
      children: iconWidgets,
    );
  }
}
