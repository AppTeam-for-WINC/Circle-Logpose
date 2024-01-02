import 'package:amazon_app/pages/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../home/home_page.dart';

class AccountSettingPopup extends ConsumerWidget {
  const AccountSettingPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: SizedBox(
        width: 360,
        height: 672,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFFF5F3FE),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: Column(
              children: [
                //一個目の緑
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
                            borderRadius: BorderRadius.circular(80)),
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
                  margin: EdgeInsets.only(top: 20),
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
                      //グループアイコン
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [ 
                            const Icon(
                            Icons.face,
                            size: 70,
                            color: Colors.grey,
                            ),
                            const Icon(
                            Icons.keyboard_double_arrow_left,
                            size: 30,
                            color: Colors.grey,
                            ),
                            const Icon(
                            Icons.collections,
                            size: 60,
                            color: Colors.grey,
                            ),
                          ]
                        )
                        
                      ),
                      //緑の部分
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
                            color: Color.fromARGB(255, 231, 238, 189),
                            borderRadius: BorderRadius.circular(80)),
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.edit,
                                color: Colors.grey,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 30),
                                child: const Text('username'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //メアド
                Container(
                  margin: EdgeInsets.only(top: 20),
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
                    color: Color.fromARGB(255, 231, 238, 189),
                    borderRadius: const BorderRadius.all(Radius.circular(60)),
                    border: Border.all(
                      color: const Color(0xFFD9D9D9),
                    ),
                  ),
                child: Row(
                  children: [
                  Padding(
                      padding: EdgeInsets.only(left: 16.0), // アイコンの左マージン
                      child: Icon(
                        Icons.mail_outline,
                        color: Colors.grey,
                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.0), // テキストの左マージン
                    child: Text('メールアドレス'),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 120.0), // アイコンの左マージン
                      child: GestureDetector(
          onTap: () {
            // アイコンがタップされたときに新しいページに遷移
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          ),
        ),
                  ),
                  ],
                  ),
                ),
                //パスワード
                Container(
                  margin: EdgeInsets.only(top: 20),
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
                    color: Color.fromARGB(255, 231, 238, 189),
                    borderRadius: const BorderRadius.all(Radius.circular(60)),
                    border: Border.all(
                      color: const Color(0xFFD9D9D9),
                    ),
                  ),
                child: Row(
                  children: [
                  Padding(
                      padding: EdgeInsets.only(left: 16.0), // アイコンの左マージン
                      child: Icon(
                        Icons.lock_outline,
                        color: Colors.grey,
                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.0), // テキストの左マージン
                    child: Text('パスワード'),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 150.0), // アイコンの左マージン
                      child: GestureDetector(
          onTap: () {
            // アイコンがタップされたときに新しいページに遷移
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          ),
        ),
                  ),
                  ],
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
                                  top: 10, right: 5, left: 5, bottom: 5),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 3,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                ),
                                itemCount: 20,
                                itemBuilder: (BuildContext context, int index) {
                                  return const GroupCard();
                                },
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
              onPressed: () {
              },
              color: const Color(0xFF7B61FF),
              borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                width: 117,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
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
    ]),),),),);
  }
}


class GroupCard extends ConsumerWidget {
  const GroupCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(216, 235, 97, 0.29),
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
  final memberIcon = Icons.perm_identity;
  final int maxIcons = 8;

  const GroupMemberIcons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> iconWidgets = [];

    int iconCount = 0;
    while (iconCount < maxIcons) {
      iconWidgets.add(
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: Icon(
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



