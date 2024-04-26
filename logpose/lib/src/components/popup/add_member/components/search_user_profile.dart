import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controllers/providers/group/member/set_group_member_list_provider.dart';
import '../../../../controllers/providers/user/set_search_user_data_provider.dart';

class SearchUserProfile extends ConsumerStatefulWidget {
  const SearchUserProfile({
    super.key,
    required this.groupId,
  });
  final String? groupId;
  @override
  ConsumerState<SearchUserProfile> createState() => _SearchUserProfileState();
}

class _SearchUserProfileState extends ConsumerState<SearchUserProfile> {
  @override
  Widget build(BuildContext context) {
    final groupId = widget.groupId;
    
    // userProfileは、値の変化の追跡を行うが、変更を適用させることはない。
    final userProfile = ref.watch(setSearchUserDataProvider(groupId));
    // userProfileNotifierは、値の変更を行うが、追跡は行わない。
    final userProfileNotifier =
        ref.watch(setSearchUserDataProvider(groupId).notifier);

    return CupertinoPageScaffold(
      child: Padding(
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
                prefix: const Icon(CupertinoIcons.search),
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
                    ref
                        .read(
                          setSearchUserDataProvider(groupId).notifier,
                        )
                        .setMemberState();
                    ref
                        .read(
                          setSearchUserDataProvider(groupId).notifier,
                        )
                        .resetState();
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
                            image: userProfile.image.startsWith('http')
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
                              color: CupertinoColors.black,
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
    );
  }
}
