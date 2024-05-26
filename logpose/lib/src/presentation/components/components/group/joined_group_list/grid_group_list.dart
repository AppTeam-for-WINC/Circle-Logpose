import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../notifiers/group_profile_list_notifier.dart';

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
    final groupList = ref.watch(groupProfileListNotifierProvider);

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
              children: groupList,
            ),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
