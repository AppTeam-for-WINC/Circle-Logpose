import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../navigations/to_group_creation_and_list_tab_slider_navigator.dart';
import '../../../common/slide_tab.dart';

class GroupCreationTab extends ConsumerStatefulWidget {
  const GroupCreationTab({super.key});

  @override
  ConsumerState createState() => GroupCreateTabState();
}

class GroupCreateTabState extends ConsumerState<GroupCreationTab> {
  Future<void> _handleToTap() async {
    final navigator = ToGroupCreationAndListTabSliderNavigator(context);
    await navigator.moveToPage();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTab(
      label: '団体作成',
      decorationColor: const Color.fromARGB(210, 229, 236, 157),
      textColor: const Color.fromARGB(210, 8, 86, 8),
      icon: CupertinoIcons.add,
      onTap: _handleToTap,
    );
  }
}
