import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../components/user/user_joined_group_tile.dart';
import '../../../../controllers/providers/group/group/watch_joined_group_profile_provider.dart';

class GroupSection extends ConsumerStatefulWidget {
  const GroupSection({super.key});
  @override
  ConsumerState createState() => _GroupSectionState();
}

class _GroupSectionState extends ConsumerState<GroupSection> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    List<Widget> userJoinedGroupTileList(List<String> groupProfile) {
      return groupProfile.map((groupId) {
        return UserJoinedGroupTile(
          groupId: groupId,
        );
      }).toList();
    }

    List<Widget> asyncGroupData() {
      final groupsProfile = ref.watch(watchJoinedGroupsProfileProvider);
      return groupsProfile.when(
        data: (groupProfile) {
          if (groupProfile.isEmpty) {
            return const [SizedBox.shrink()];
          }

          return userJoinedGroupTileList(groupProfile);
        },
        loading: () => const [SizedBox.shrink()],
        error: (error, stack) => [Text('$error')],
      );
    }

    return Container(
      width: deviceWidth * 0.88,
      height: deviceHeight * 0.24,
      margin: const EdgeInsets.only(top: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: CupertinoColors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 3),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Row(
                children: [
                  Text('所属団体'),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                width: deviceWidth * 0.86,
                height: deviceHeight * 0.19,
                padding: const EdgeInsets.only(
                  top: 5,
                  right: 5,
                  left: 5,
                  bottom: 5,
                ),
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: asyncGroupData(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
