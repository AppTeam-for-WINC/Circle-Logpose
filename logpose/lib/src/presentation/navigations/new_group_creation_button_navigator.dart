import 'package:flutter/cupertino.dart';

import '../components/components/slide/slider/group_creation_and_list_tab_slider.dart';

class NewGroupCreationButtonNavigator {
  NewGroupCreationButtonNavigator(this.context);

  final BuildContext context;

  Future<void> moveToPage() async {
    await Navigator.push(
      context,
      CupertinoPageRoute<CupertinoPageRoute<GroupCreationAndListTabSlider>>(
        builder: (context) => const GroupCreationAndListTabSlider(),
      ),
    );
  }
}
