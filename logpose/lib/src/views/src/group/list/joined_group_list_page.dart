import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../components/gradation/gradation.dart';
import '../../../../components/group/create_new_group_button/create_new_group_button.dart';
import '../../../../components/group/grid_group_list/grid_group_list.dart';

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
            bottom: 0, // 画面の底部に配置
            child: Gradation(),
          ),
          Positioned(
            top: deviceHeight * 0.875,
            child: const CreateNewGroupButton(),
          ),
        ],
      ),
    );
  }
}
