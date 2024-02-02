import 'package:amazon_app/pages/common/slide/src/tab_component.dart';
import 'package:amazon_app/pages/common/slide/src/slide_tab.dart';
import 'package:flutter/cupertino.dart';

Future<void> onTapSegmentTab(
    BuildContext context, SegmentTab tab, String? tabName, int slideNum) async {
  if (tabName == null) {
    return;
  }
  if (slideNum == 0) {
    debugPrint('$tabNameのラベルが押されました。');
    await showCupertinoModalPopup<TabComponent>(
      context: context,
      builder: (BuildContext context) {
        return TabComponent(tab: tab, tabName: tabName);
      },
    );
  }
}
