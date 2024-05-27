import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/responsive_util.dart';

import '../../../../notifiers/group_profile_list_notifier.dart';

class GridGroupList extends ConsumerStatefulWidget {
  const GridGroupList({super.key});

  @override
  ConsumerState<GridGroupList> createState() => _GridGroupListState();
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
            LayoutBuilder(
              builder: (context, constraints) {
                if (ResponsiveUtil.isMobile(context)) {
                  return const SizedBox(height: 200);
                } else if (ResponsiveUtil.isTablet(context)) {
                  return const SizedBox(height: 400);
                } else {
                  return const SizedBox(height: 600);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
