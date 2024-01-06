import 'package:amazon_app/pages/home/home_page.dart';
import 'package:amazon_app/pages/popup/member_add/member_add_popup.dart';
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(60, 30, 80, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(
                                CupertinoIcons.arrow_clockwise,
                                size: 80,
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                size: 50,
                              ),
                              //imagepicker実装予定地
                              GestureDetector(
                                onTap: (){
                                  
                                },
                                child: Container(
                                width: 80,
                                height: 80,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD9D9D9),
                                    borderRadius: BorderRadius.circular(40),),
                                  child: const Center(
                                    child: Icon(
                                      Icons.camera_alt,
                                      color:Colors.white,
                                      size: 25,
                                    ),
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
                          child: const Padding(
                            padding: EdgeInsets.only(left: 13),
                            child: CupertinoTextField(
                              prefix: Icon(Icons.add),
                              style: TextStyle(fontSize: 18),
                              placeholder: '団体名',
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
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
                top: 380,
                left: 340,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      const CircleBorder(),
                    ),
                    backgroundColor: MaterialStateProperty.all(const Color(0xFFD8EB61)),
                  ),
                  child: const Icon(
                    Icons.person_remove,
                    color: Colors.black,
                    size: 20,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute<MaterialPageRoute<dynamic>>(
                        builder: (context) => const ShowMemberAddPopup(),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 420,
                left: 340,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      const CircleBorder(),
                    ),
                    backgroundColor: MaterialStateProperty.all(const Color(0xFFEB6161)),
                  ),
                  child: const Icon(
                    Icons.person_remove,
                    color: Colors.black,
                    size: 20,
                  ),
                  onPressed: () async {
                  
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
