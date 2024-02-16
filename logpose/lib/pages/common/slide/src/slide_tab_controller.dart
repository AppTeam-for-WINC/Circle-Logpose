import 'package:flutter/cupertino.dart';

import 'slide_tab.dart';
import 'tab_component.dart';

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
    await showCupertinoModalPopup<TabComponent>(
      context: context,
      builder: (BuildContext context) {
        return TabComponent(tab: tab, tabName: tabName);
      },
    );
  }
}
