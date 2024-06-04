import 'package:flutter/cupertino.dart';

import '../src/presentation/components/components/slide/src/segment_tab.dart';
import '../src/presentation/components/components/slide/tab_manager.dart';

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
