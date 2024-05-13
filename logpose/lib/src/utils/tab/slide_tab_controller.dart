import 'package:flutter/cupertino.dart';

import '../../components/slide/src/slide_tab.dart';
import '../../components/slide/src/tab_manager.dart';

Future<void> onTapSegmentTab(
  BuildContext context,
  SegmentTab tab,
  String? tabName,
  int slideNum,
) async {
  if (tabName == null) {
    return;
  }
  if (slideNum == 0) {
    await showCupertinoModalPopup<TabManager>(
      context: context,
      builder: (BuildContext context) {
        return TabManager(tab: tab, tabName: tabName);
      },
    );
  }
}
