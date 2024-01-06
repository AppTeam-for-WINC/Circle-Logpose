import 'package:amazon_app/pages/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'parts/group_member.dart';

class GroupCreatePage extends ConsumerWidget {
  const GroupCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity, // 幅を画面幅いっぱいに広げる
      height: double.infinity, // 高さを画面高さいっぱいに広げる
      alignment: Alignment.center,
      color: const Color.fromARGB(255, 245, 242, 254),
      child: Container(
        width: 400,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    //上トピック
                    margin: const EdgeInsets.only(top: 10),
                    width: 350,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 147, 145, 145),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.group_add,
                              size: 20,
                            ),
                            Text('団体作成'),
                            Icon(
                              Icons.expand_more,
                              size: 20,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 20,
                            ),
                            Text('団体'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //中央トピック
                    width: 350,
                    height: 200,
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
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(60, 30, 80, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                CupertinoIcons.arrow_clockwise,
                                size: 80,
                              ),
                              Icon(
                                Icons.add,
                                size: 50,
                              ),
                              Icon(
                                Icons.add_a_photo,
                                size: 80,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 272,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: const Color.fromARGB(255, 244, 253, 194),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 2,
                                offset: Offset(0, 3),
                                color: Color.fromARGB(225, 127, 145, 145),
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 3),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.add,
                                    size: 24,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    '団体名',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //下トピック
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
                        SingleChildScrollView(
                          child: Center(
                            child: SizedBox(
                              height: 344,
                              width: 330,
                              child: GridView.count(
                                crossAxisSpacing: 26,
                                mainAxisSpacing: 14,
                                childAspectRatio: 2.5,
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(10),
                                children: const <Widget>[
                                  //後でデータベースと繋げます
                                  GroupMember(),
                                  GroupMember(),
                                  GroupMember(),
                                  GroupMember(),
                                  GroupMember(),
                                  GroupMember(),
                                  GroupMember(),
                                  GroupMember(),
                                  GroupMember(),
                                  GroupMember(),
                                  GroupMember(),
                                  GroupMember(),
                                  GroupMember(),
                                  GroupMember(),
                                  GroupMember(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    // 浮遊ボタン
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
                          await Navigator.push(
                            context,
                            MaterialPageRoute<MaterialPageRoute<dynamic>>(
                              builder: (context) => const HomePage(),
                            ),
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
                ],
              ),
              Positioned(
                top: 410,
                left: 355,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_remove,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
              //追加ボタン
              Positioned(
                top: 365,
                left: 355,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_add,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
