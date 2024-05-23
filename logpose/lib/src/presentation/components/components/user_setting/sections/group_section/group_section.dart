import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../notifiers/group_section_notifier.dart';

class GroupSection extends ConsumerStatefulWidget {
  const GroupSection({super.key});
  @override
  ConsumerState createState() => _GroupSectionState();
}

class _GroupSectionState extends ConsumerState<GroupSection> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final joinedGroupList = ref.watch(joinedGroupListNotifierProvider);

    return Container(
      width: deviceWidth * 0.88,
      height: deviceHeight * 0.24,
      margin: const EdgeInsets.only(top: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: CupertinoColors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 3),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Row(children: [Text('所属団体')]),
            ),
            SingleChildScrollView(
              child: Container(
                width: deviceWidth * 0.86,
                height: deviceHeight * 0.19,
                padding: const EdgeInsets.only(
                  top: 5,
                  right: 5,
                  left: 5,
                  bottom: 5,
                ),
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  crossAxisCount: 1,
                  mainAxisSpacing: 8,
                  childAspectRatio: 5.5,
                  children: joinedGroupList,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
