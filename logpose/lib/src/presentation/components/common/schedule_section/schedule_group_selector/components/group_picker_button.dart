import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../navigations/modals/to_group_picker_navigator.dart';

import '../../../../../providers/group/group/selected_group_name_provider.dart';

class GroupPickerButton extends ConsumerStatefulWidget {
  const GroupPickerButton({super.key, required this.groupIdList});

  final List<String> groupIdList;

  @override
  ConsumerState<GroupPickerButton> createState() => _GroupPickerButtonState();
}

class _GroupPickerButtonState extends ConsumerState<GroupPickerButton> {
  Future<void> _handleToTap() async {
    final navigator = ToGroupPickerNavigator(context);
    await navigator.showModal(widget.groupIdList);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.only(left: 10),
      onPressed: _handleToTap,
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
