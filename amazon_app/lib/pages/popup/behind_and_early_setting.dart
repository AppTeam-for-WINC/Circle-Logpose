// import 'dart:html';
import 'package:amazon_app/pages/popup/schedule_detail_confirm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Behind_and_early_setting extends ConsumerWidget {
  const Behind_and_early_setting({super.key});

  @override
  //絶対書く
  Widget build(BuildContext context, WidgetRef ref) {
    final double deviceHight = MediaQuery.of(context).size.height;
    final List productsList = [
      Icons.sentiment_satisfied_alt_rounded,
      Icons.sentiment_satisfied,
      Icons.sentiment_neutral,
      Icons.sentiment_dissatisfied,
    ];
    return CupertinoApp(
      home: CupertinoPageScaffold(
        child: CupertinoButton(
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: 32, right: 32, bottom: deviceHight * 0.02),
                  child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(34),
                        child: SizedBox(
                            width: 360,
                            height: 500,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 500,
                                  decoration: const BoxDecoration(
                                      color: Colors.white), //メインの白
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFD8EB61)), //上の黄緑
                                ),
                                const Positioned(
                                  top: 70,
                                  left: 30,
                                  child: Icon(
                                    Icons.groups,
                                    size: 60,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(top: 120),
                                        child: const Text(
                                          'Designner23',
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(top: 15),
                                        child: const Text(
                                            '2023/9/20 13:00-14:00'),
                                      ),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(top: 15),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.group,
                                                size: 25,
                                                color: Colors.grey,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 8),
                                                child: const Text(
                                                  "参加メンバー |",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              const PresentMember(),
                                            ],
                                          )),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 70, right: 30),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              
                                              onTap: () {},
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Icon(productsList[0]),
                                                    Text("出席"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Icon(productsList[1]),
                                                    Text("早退"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Icon(productsList[2]),
                                                    Text("遅刻"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Icon(productsList[3]),
                                                    Text("欠席"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          child: Icon(Icons.schedule),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              right: 80, top: 20),
                                          child: const Text(
                                            "参加時間",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              right: 30, top: 20),
                                          child: const Text(
                                            '13:30-14:00',
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      )),
                );
              },
            );
          },
          //ポップアップを開くボタン
          child: const Text(
            'a',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
