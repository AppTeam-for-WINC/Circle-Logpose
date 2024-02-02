import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'parts/join_member.dart';

// 担当　小山祐希

// ポップアップ画面
class ScheduleJoinMember extends ConsumerStatefulWidget {
  const ScheduleJoinMember({super.key});

  @override
  ConsumerState<ScheduleJoinMember> createState() {
    return ScheduleJoinMemberState();
  }
}

class ScheduleJoinMemberState extends ConsumerState<ScheduleJoinMember> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
        bottom: deviceHeight * 0.02,
        right: 32,
        left: 32,
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(34),
          child: SizedBox(
            width: 360,
            height: 500,
            child: Stack(
              children: [ 
                Column(
                  children: [
                    Container(
                      height: 99,
                      color: const Color(0xFFD8EB61),
                    ),
                    Container(
                      height: 401,
                      color: Colors.white,
                    ),
                  ],
                ),
                const Positioned(
                  top: 80,
                  left: 24,
                  child: FittedBox(
                    child: Icon(
                      Icons.group,
                      size: 40,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 140),
                        child: const Text(
                          'Designer23',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: const Text(
                          '2023/9/20  13:00-14:00',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF043139),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 15,
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.group,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '参加メンバー',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisSpacing: 26,
                          mainAxisSpacing: 14,
                          childAspectRatio: 2.5,
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10),
                          children: const <Widget>[
                            //後でデータベースと繋げます
                            JoinMember(),
                            JoinMember(),
                            JoinMember(),
                            JoinMember(),
                            JoinMember(),
                            JoinMember(),
                            JoinMember(),
                            JoinMember(),
                            JoinMember(),
                            JoinMember(),
                            JoinMember(),
                          ],
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
