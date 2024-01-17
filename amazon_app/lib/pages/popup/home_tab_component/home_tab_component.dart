import 'package:amazon_app/pages/popup/home_tab_component/parts/attendance_tab.dart';
import 'package:amazon_app/pages/popup/home_tab_component/parts/user_setting_tab.dart';
import 'package:amazon_app/pages/slide/src/slide_tab.dart';
// import 'package:amazon_app/pages/slide/src/slide_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTabComponent extends ConsumerStatefulWidget {
  const HomeTabComponent({super.key, required this.tab, required this.tabName});
  final SegmentTab tab;
  final String tabName;

  @override
  ConsumerState createState() => HomeTabComponentState();
}

class HomeTabComponentState extends ConsumerState<HomeTabComponent> {
  @override
  Widget build(BuildContext context) {
    // final tab = widget.tab;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
        padding: EdgeInsets.only(
          // top: 70,
          top: deviceHeight * 0.076,
          right: 170,
        ),
        child: Column(
          children: [
            AttendanceTab(),
            SizedBox(height: 20),
            UserSettingTab(),
          ],
        )

        // child: tab.label,

        // Flexible(
        //   child: InkWell(
        //     splashColor: Colors.white,
        //     highlightColor: const Color(0xFF7B61FF),
        //     borderRadius: BorderRadius.circular(20),
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 8),
        //       child: Container(
        //         child: tab.label,
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
