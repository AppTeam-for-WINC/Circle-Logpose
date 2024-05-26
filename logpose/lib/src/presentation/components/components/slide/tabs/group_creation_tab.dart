import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../navigations/to_group_creation_and_list_tab_slider_navigator.dart';

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
    return GestureDetector(
      onTap: _handleToTap,
      child: Container(
        width: 180,
        height: 55,
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.only(
          left: 10,
        ),
        child: Row(
          children: [
            Container(
              width: 33,
              height: 33,
              decoration: BoxDecoration(
                color: const Color.fromARGB(210, 229, 236, 157),
                borderRadius: BorderRadius.circular(33),
              ),
              child: const Center(child: Icon(CupertinoIcons.add)),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Text(
                '団体作成',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(210, 8, 86, 8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
