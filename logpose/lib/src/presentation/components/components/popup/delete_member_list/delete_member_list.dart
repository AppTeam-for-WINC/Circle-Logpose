import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../domain/entity/user_profile.dart';

import '../../../../../domain/providers/group/members/listen_group_member_profile_list_provider.dart';
import '../../../../../domain/providers/user/fetch_user_profile_provider.dart';

import '../../../../notifiers/set_group_member_list_notifier.dart';

import '../../../common/group_member_tile/group_member_tile.dart';

class DeleteMemberList extends ConsumerStatefulWidget {
  const DeleteMemberList({super.key, required this.groupId});
  final String groupId;

  @override
  ConsumerState<DeleteMemberList> createState() => _DeleteMemberListState();
}

class _DeleteMemberListState extends ConsumerState<DeleteMemberList> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final groupId = widget.groupId;

    return Stack(
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: SizedBox(
              width: deviceWidth * 0.8,
              height: deviceHeight * 0.55,
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
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.group, size: 25),
                            SizedBox(width: 10),
                            Text(
                              'メンバーを削除',
                              style: TextStyle(color: CupertinoColors.black),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: SizedBox(
                          height: deviceHeight * 0.4,
                          child: GridView.count(
                            mainAxisSpacing: 8,
                            childAspectRatio: 5.5,
                            crossAxisCount: 1,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(10),
                            children: <Widget>[
                              ref.watch(fetchUserProfileProvider).when(
                                    data: (adminUserProfile) {
                                      if (adminUserProfile == null) {
                                        return const SizedBox.shrink();
                                      }
                                      return GroupMemberTile(
                                        memberProfile: adminUserProfile,
                                        adminOrMembership: 'admin',
                                      );
                                    },
                                    loading: () => const SizedBox.shrink(),
                                    error: (error, stack) => Text('$error'),
                                  ),
                              ref
                                  .watch(
                                    listenGroupMembershipProfileListProvider(
                                      groupId,
                                    ),
                                  )
                                  .when(
                                    data: (
                                      List<UserProfile?> membershipProfileList,
                                    ) {
                                      if (membershipProfileList.isEmpty) {
                                        return const SizedBox.shrink();
                                      }
                                      return Column(
                                        children: membershipProfileList
                                            .map((membershipProfile) {
                                          if (membershipProfile == null) {
                                            return const SizedBox.shrink();
                                          }
                                          return GroupMemberTile(
                                            memberProfile: membershipProfile,
                                            adminOrMembership: 'membership',
                                            groupId: groupId,
                                          );
                                        }).toList(),
                                      );
                                    },
                                    loading: () => const SizedBox.shrink(),
                                    error: (error, stack) => Text('$error'),
                                  ),
                              ...ref
                                  .watch(setGroupMemberListNotifierProvider)
                                  .map(
                                    (memberProfile) => GroupMemberTile(
                                      memberProfile: memberProfile,
                                      adminOrMembership: 'membership',
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
