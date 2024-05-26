import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../domain/providers/group/group/selected_group_name_provider.dart';
import '../../../../../navigations/modals/group_picker_button_modal_navigator.dart';

class GroupPickerButton extends ConsumerStatefulWidget {
  const GroupPickerButton({super.key, required this.groupIdList});

  final List<String> groupIdList;

  @override
  ConsumerState<GroupPickerButton> createState() => _GroupPickerButtonState();
}

class _GroupPickerButtonState extends ConsumerState<GroupPickerButton> {
  Future<void> showModal() async {
    final navigator = GroupPickerButtonModalNavigator(
      context: context,
      groupIdList: widget.groupIdList,
    );

    await navigator.showModal();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.only(left: 10),
      onPressed: showModal,
      child: Text(
        ref.watch(selectedGroupNameProvider),
        style: const TextStyle(
          fontSize: 18,
          color: Color(0xFF7B61FF),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
