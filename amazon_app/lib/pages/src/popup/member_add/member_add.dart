import 'package:amazon_app/pages/src/group/create/parts/contents/group_contents_controller.dart';
import 'package:amazon_app/pages/src/popup/member_add/member_add_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddMember extends ConsumerStatefulWidget {
  const AddMember({
    super.key,
    required this.groupId,
  });
  final String? groupId;

  @override
  ConsumerState<AddMember> createState() => ShowMemberAddState();
}

class ShowMemberAddState extends ConsumerState<AddMember> {
  @override
  Widget build(BuildContext context) {
    final groupId = widget.groupId;

    //userProfileは、値の変化の追跡を行うが、変更を適用させることはない。
    final userProfile = ref.watch(memberAddProvider);

    //userProfileNotifierは、値の変更を行うが、追跡は行わない。
    final userProfileNotifier = ref.watch(memberAddProvider.notifier);
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 10,
                          ),
                          child: CupertinoTextField(
                            controller: userProfileNotifier.accountIdController,
                            prefix: const Icon(Icons.search),
                            style: const TextStyle(fontSize: 16),
                            placeholder: 'ユーザIDの検索',
                            decoration: const BoxDecoration(
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
                      if (userProfile != null)
                        Container(
                          height: 30,
                          width: 100,
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
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              //後で、OOを追加しました。をalert()などで通知させる。
                              print('${userProfileNotifier.username!}を追加しました。');
                              ref.read(memberAddProvider.notifier).resetState();
                              ref.read(groupMemberListProvider.notifier).addMember(userProfile);
                            },
                            child: Row(
                              children: [
                                // Image.network(
                                Image.asset(
                                  userProfileNotifier.userImage!,
                                  width: 20,
                                  height: 20,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    userProfileNotifier.username!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF9A9A9A),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (groupId != null) 
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
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
                      child: CupertinoButton(
                        onPressed: () async {},
                        padding: EdgeInsets.zero,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.content_copy,
                              size: 12,
                              color: Colors.white,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 15),
                              child: const Text(
                                '招待リンクのコピー',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
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
      ),
    );
  }
}
