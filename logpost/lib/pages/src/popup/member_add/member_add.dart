import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controller/common/copy_to_clipboard.dart';
import '../../group/create/parts/components/group_contents_controller.dart';
import 'member_add_controller.dart';

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
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final groupId = widget.groupId;

    //userProfileは、値の変化の追跡を行うが、変更を適用させることはない。
    final userProfile = ref.watch(memberAddProvider);

    //userProfileNotifierは、値の変更を行うが、追跡は行わない。
    final userProfileNotifier = ref.watch(memberAddProvider.notifier);
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: SizedBox(
          width: deviceWidth * 0.8,
          height: deviceHeight * 0.35,
          // height: 300,
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
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 10,
                      right: 20,
                      bottom: 10,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 244, 219, 251),
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
                          child: CupertinoTextField(
                            controller: userProfileNotifier.accountIdController,
                            prefix: const Icon(Icons.search),
                            style: const TextStyle(fontSize: 16),
                            placeholder: 'ユーザIDの検索',
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 244, 219, 251),
                              borderRadius: BorderRadius.circular(80),
                            ),
                            autofocus: true,
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
                            height: 60,
                            width: 200,
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
                                ref.read(memberAddProvider.notifier).resetState();
                                ref
                                    .read(setGroupMemberListProvider.notifier)
                                    .addMember(userProfile);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            userProfile.image.startsWith('http')
                                                ? NetworkImage(userProfile.image)
                                                : AssetImage(userProfile.image)
                                                    as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        minWidth: 50,
                                        maxWidth: 120,
                                      ),
                                      child: Text(
                                        userProfileNotifier.username!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                        ),
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
                      padding: const EdgeInsets.only(top: 60),
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
                        child: DecoratedBox(
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
                            onPressed: () async {
                              final invitationlink = await GroupInvitationLink
                                  .readGroupInvitationLink(
                                groupId,
                              );
                              if (invitationlink == null) {
                                return;
                              }
                              copyToClipboard(invitationlink);
                            },
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
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
