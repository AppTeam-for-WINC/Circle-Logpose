import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowMemberAddPopup extends ConsumerWidget {
  const ShowMemberAddPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: SizedBox(
        width: 360,
        height: 520,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFFF5F3FE),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 40,
            ),
            child: Column(
              children: [
                //ここのContainerを切り出す
                Container(
                  width: 275,
                  height: 174,
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
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          bottom: 10,
                        ),
                        child: const Icon(
                          Icons.groups,
                          size: 80,
                        ),
                      ),
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
                                Icons.group,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 30),
                                child: const Text('Group3'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //ここのContainer切り出す
                Container(
                  width: 300,
                  height: 220,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFD9D9D9),
                        offset: Offset(1, 3),
                        blurRadius: 3,
                        spreadRadius: 1,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(60),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    top: 30,
                    left: 25,
                    right: 25,
                  ),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            'メンバー追加',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF9A9A9A),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 200,
                        height: 40,
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD8EB61),
                          borderRadius: BorderRadius.circular(80),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFFD9D9D9),
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3, horizontal: 10),
                          child: CupertinoTextField(
                            prefix: Icon(Icons.search),
                            style: TextStyle(fontSize: 16),
                            placeholder: 'ユーザIDの検索',
                            decoration: BoxDecoration(
                              color: Color(0xFFD8EB61),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const Row(
                          children: [
                            Text(
                              'この人ですか？',
                              style: TextStyle(
                                color: Color(0xFF9A9A9A),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 80,
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        margin: const EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F0FF),
                          borderRadius: BorderRadius.circular(80),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFFD9D9D9),
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 20,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: const Text(
                                'User1',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF9A9A9A),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: 190,
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7B61FF),
                    borderRadius: BorderRadius.circular(80),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFD9D9D9),
                        offset: Offset(0, 2),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.content_copy,
                        size: 20,
                        color: Colors.white,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: const Text(
                          '団体リンクのコピー',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ],
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
