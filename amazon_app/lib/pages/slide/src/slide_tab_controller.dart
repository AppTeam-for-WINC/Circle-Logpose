import 'package:amazon_app/pages/popup/home_tab_component/home_tab_component.dart';
import 'package:amazon_app/pages/slide/src/slide_tab.dart';
import 'package:flutter/cupertino.dart';

Future<void> onTapSegmentTab(
    BuildContext context, SegmentTab tab, String? tabName, int slideNum) async {
  if (tabName == null) {
    return;
  }
  if (slideNum == 0) {
    debugPrint('$tabNameのラベルが押されました。');
    await showCupertinoModalPopup<HomeTabComponent>(
      context: context,
      builder: (BuildContext context) {
        return HomeTabComponent(tab: tab, tabName: tabName);
      },
    );
  }
}
