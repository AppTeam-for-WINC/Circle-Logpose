import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../handlers/group_picker_modal_handler.dart';
import 'components/group_name_modal.dart';
import 'components/group_picker_modal_close_button.dart';

class GroupPickerModal extends ConsumerStatefulWidget {
  const GroupPickerModal({super.key, required this.groupIdList});

  final List<String> groupIdList;

  @override
  ConsumerState createState() => _GroupPickerModalState();
}

class _GroupPickerModalState extends ConsumerState<GroupPickerModal> {
  @override
  void initState() {
    super.initState();
    if (widget.groupIdList.length == 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final handler =
            GroupPickerModalHandler(ref: ref, groupIdList: widget.groupIdList);
        await handler.handleToSelectGroup();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 360,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(36),
      ),
      child: Center(
        child: Column(
          children: [
            GroupNameModal(groupIdList: widget.groupIdList),
            const GroupPickerModalCloseButton(),
          ],
        ),
      ),
    );
  }
}
