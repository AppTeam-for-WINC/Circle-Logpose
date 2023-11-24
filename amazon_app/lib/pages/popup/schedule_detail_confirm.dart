import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleDetailConfirm extends ConsumerWidget {
  const ScheduleDetailConfirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
        left: 32,
        right: 32,
        bottom: deviceHeight * 0.02,
      ),
      child: Center(
        child: CupertinoPopupSurface(
          child: SizedBox(
            width: 360,
            height: 500,
            child: Stack(
              children: [
                // ポップアップ下部の白色↓
                Container(
                  width: double.infinity,
                  height: 500,
                  decoration: const BoxDecoration(color: Colors.white),
                ),
                // ポップアップ下部の白色↑
                //ポップアップ上部の黄緑色↓
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(color: Colors.yellow[200]),
                ),
                // ポップアップ上部の黄緑色↑
                // 団体アイコン↓
                const Positioned(
                  top: 70,
                  left: 30,
                  child: Icon(
                    Icons.groups,
                    size: 60,
                  ),
                ),
                // 団体アイコン↑
                // 出席アイコン↓
                Positioned(
                  top: 120,
                  left: 250,
                  child: Icon(
                    Icons.sentiment_satisfied,
                    size: 70,
                    color: Colors.pink[300],
                  ),
                ),
                // 出席アイコン↑
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 団体名↓
                      Container(
                        margin: const EdgeInsets.only(top: 120),
                        child: const Text(
                          'TeamName',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      // 団体名↑
                      // 活動日時↓
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: const Text('2023/9/20 13:00-14:00'),
                      ),
                      // 活動日時↑
                      // 参加メンバーのコンテナ↓
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            // 参加メンバー左部のアイコン↓
                            const Icon(
                              Icons.group,
                              size: 25,
                              color: Colors.grey,
                            ),
                            // 参加メンバー左部のアイコン↑
                            // 参加メンバーテキスト↓
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: const Text(
                                '参加メンバー |',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            // 参加メンバーテキスト↑
                            const PresentMember(),
                          ],
                        ),
                      ),
                      // 参加メンバーのコンテナ↑
                      // 詳細のコンテナ↓
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // 詳細左部のアイコン↓
                                const Icon(
                                  Icons.edit_square,
                                  size: 25,
                                  color: Colors.grey,
                                ),
                                // 詳細左部のアイコン↑
                                // 詳細テキスト↓
                                Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  child: const Text(
                                    '詳細',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                // 詳細テキスト↑
                              ],
                            ),
                            // 詳細内容↓
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.only(right: 30),
                              child: const Text(
                                '詳細内容ああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                                maxLines: 7,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // 詳細内容↑
                          ],
                        ),
                      ),
                      // 詳細のコンテナ↑
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // return CupertinoApp(
    //   home: CupertinoPageScaffold(
    //     child: CupertinoButton(
    //       onPressed: () {
    //         showCupertinoModalPopup(
    //           context: context,
    //           builder: (BuildContext context) {
    //             return Padding(
    //               padding: EdgeInsets.only(
    //                 left: 32,
    //                 right: 32,
    //                 bottom: deviceHeight * 0.02,
    //               ),
    //               child: Center(
    //                 child: CupertinoPopupSurface(
    //                   child: SizedBox(
    //                     width: 360,
    //                     height: 500,
    //                     child: Stack(
    //                       children: [
    //                         // ポップアップ下部の白色↓
    //                         Container(
    //                           width: double.infinity,
    //                           height: 500,
    //                           decoration:
    //                               const BoxDecoration(color: Colors.white),
    //                         ),
    //                         // ポップアップ下部の白色↑
    //                         //ポップアップ上部の黄緑色↓
    //                         Container(
    //                           width: double.infinity,
    //                           height: 100,
    //                           decoration:
    //                               BoxDecoration(color: Colors.yellow[200]),
    //                         ),
    //                         // ポップアップ上部の黄緑色↑
    //                         // 団体アイコン↓
    //                         const Positioned(
    //                           top: 70,
    //                           left: 30,
    //                           child: Icon(
    //                             Icons.groups,
    //                             size: 60,
    //                           ),
    //                         ),
    //                         // 団体アイコン↑
    //                         // 出席アイコン↓
    //                         Positioned(
    //                           top: 120,
    //                           left: 250,
    //                           child: Icon(
    //                             Icons.sentiment_satisfied,
    //                             size: 70,
    //                             color: Colors.pink[300],
    //                           ),
    //                         ),
    //                         // 出席アイコン↑
    //                         Container(
    //                           margin: const EdgeInsets.only(left: 30),
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               // 団体名↓
    //                               Container(
    //                                 margin: const EdgeInsets.only(top: 120),
    //                                 child: const Text(
    //                                   'TeamName',
    //                                   style: TextStyle(fontSize: 30),
    //                                 ),
    //                               ),
    //                               // 団体名↑
    //                               // 活動日時↓
    //                               Container(
    //                                 margin: const EdgeInsets.only(top: 15),
    //                                 child: const Text('2023/9/20 13:00-14:00'),
    //                               ),
    //                               // 活動日時↑
    //                               // 参加メンバーのコンテナ↓
    //                               Container(
    //                                 margin: const EdgeInsets.only(top: 15),
    //                                 child: Row(
    //                                   children: [
    //                                     // 参加メンバー左部のアイコン↓
    //                                     const Icon(
    //                                       Icons.group,
    //                                       size: 25,
    //                                       color: Colors.grey,
    //                                     ),
    //                                     // 参加メンバー左部のアイコン↑
    //                                     // 参加メンバーテキスト↓
    //                                     Container(
    //                                       margin:
    //                                           const EdgeInsets.only(left: 8),
    //                                       child: const Text(
    //                                         '参加メンバー |',
    //                                         style: TextStyle(
    //                                           color: Colors.grey,
    //                                         ),
    //                                       ),
    //                                     ),
    //                                     // 参加メンバーテキスト↑
    //                                     const PresentMember(),
    //                                   ],
    //                                 ),
    //                               ),
    //                               // 参加メンバーのコンテナ↑
    //                               // 詳細のコンテナ↓
    //                               Container(
    //                                 margin: const EdgeInsets.only(top: 15),
    //                                 child: Column(
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     Row(
    //                                       children: [
    //                                         // 詳細左部のアイコン↓
    //                                         const Icon(
    //                                           Icons.edit_square,
    //                                           size: 25,
    //                                           color: Colors.grey,
    //                                         ),
    //                                         // 詳細左部のアイコン↑
    //                                         // 詳細テキスト↓
    //                                         Container(
    //                                           margin: const EdgeInsets.only(
    //                                               left: 8),
    //                                           child: const Text(
    //                                             '詳細',
    //                                             style: TextStyle(
    //                                               color: Colors.grey,
    //                                             ),
    //                                           ),
    //                                         ),
    //                                         // 詳細テキスト↑
    //                                       ],
    //                                     ),
    //                                     // 詳細内容↓
    //                                     Container(
    //                                       margin:
    //                                           const EdgeInsets.only(top: 10),
    //                                       padding:
    //                                           const EdgeInsets.only(right: 30),
    //                                       child: const Text(
    //                                         '詳細内容ああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ',
    //                                         style: TextStyle(
    //                                           color: Colors.grey,
    //                                           fontSize: 15,
    //                                         ),
    //                                         maxLines: 7,
    //                                         overflow: TextOverflow.ellipsis,
    //                                       ),
    //                                     ),
    //                                     // 詳細内容↑
    //                                   ],
    //                                 ),
    //                               ),
    //                               // 詳細のコンテナ↑
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //         );
    //       },
    //       // ポップアップを開くボタン↓
    //       child: const Text(
    //         'open',
    //         style: TextStyle(
    //           fontSize: 30,
    //         ),
    //       ),
    //       // ポップアップを開くボタン↑
    //     ),
    //   ),
    // );
  }
}

// 参加メンバーのアイコン↓
class PresentMember extends StatelessWidget {
  // 参加メンバーのアイコンを取得するように変更してください
  final memberIcon = Icons.perm_identity;
  final int maxIcons = 5;

  const PresentMember({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> iconWidgets = [];

    int iconCount = 0;
    while (iconCount < maxIcons) {
      iconWidgets.add(
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: Icon(
            memberIcon,
            size: 20,
          ),
        ),
      );
      iconCount++;
    }

    if (iconCount >= maxIcons) {
      iconWidgets.add(
        const Text(
          '…',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Row(
      children: iconWidgets,
    );
  }
}
//参加メンバーのアイコン↑