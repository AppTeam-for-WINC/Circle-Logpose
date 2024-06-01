import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../pages/group/group_creation_page.dart';
import '../../../../../pages/group/joined_group_list_page.dart';

import 'components/group_creation_and_list_segment_view.dart';

class GroupCreationAndListTabSlider extends ConsumerWidget {
  const GroupCreationAndListTabSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.zero,
              child: TabBarView(
                children: [
                  GroupCreationPage(),
                  JoinedGroupListPage(),
                ],
              ),
            ),
            GroupCreationAndListSegmentView(),
          ],
        ),
      ),
    );
  }
}
