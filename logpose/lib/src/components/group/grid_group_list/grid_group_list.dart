import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/providers/group/group/watch_joined_group_profile_provider.dart';
import 'components/group_box.dart';

class GridGroupList extends ConsumerStatefulWidget {
  const GridGroupList({super.key});

  @override
  ConsumerState createState() => _GridGroupListState();
}

class _GridGroupListState extends ConsumerState<GridGroupList> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
       final groupsProfile = ref.watch(watchJoinedGroupsProfileProvider);

    return SizedBox(
      width: deviceWidth,
      height: deviceHeight,
      child: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.all(24),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: 2,
              children: groupsProfile.when(
                data: (groupProfile) {
                  if (groupProfile.isEmpty) {
                    return const [SizedBox.shrink()];
                  }
                  return groupProfile.map((groupId) {
                    return GroupBox(groupId: groupId);
                  }).toList();
                },
                loading: () => const [SizedBox.shrink()],
                error: (error, stack) => [Text('Error: $error')],
              ),
            ),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
