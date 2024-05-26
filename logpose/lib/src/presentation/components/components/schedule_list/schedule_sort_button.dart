import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../handlers/schedule_sort_button_hanlder.dart';

class ScheduleSortButton extends ConsumerStatefulWidget {
  const ScheduleSortButton({super.key});

  @override
  ConsumerState<ScheduleSortButton> createState() {
    return _ScheduleSortButtonState();
  }
}

class _ScheduleSortButtonState extends ConsumerState<ScheduleSortButton> {
  void _handleSort() {
    ScheduleSortButtonHandler(context, ref).handleToSort();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: _handleSort,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('並び替え', style: TextStyle(color: Color(0xFF7B61FF))),
          Icon(CupertinoIcons.sort_down, color: Color(0xFF7B61FF)),
        ],
      ),
    );
  }
}
