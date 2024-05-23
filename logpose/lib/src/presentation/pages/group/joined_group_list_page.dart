import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/common/bottom_gradation.dart';

import '../../components/components/group/joined_group_list/grid_group_list.dart';
import '../../components/components/group/joined_group_list/new_group_creation_button.dart';

class JoinedGroupListPage extends ConsumerWidget {
  const JoinedGroupListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFFF5F3FE),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            top: deviceHeight * 0.15,
            child: const GridGroupList(),
          ),
          const Positioned(
            bottom: 0,
            child: BottomGradation(),
          ),
          Positioned(
            top: deviceHeight * 0.875,
            child: const NewGroupCreationButton(),
          ),
        ],
      ),
    );
  }
}
