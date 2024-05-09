import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleSortButton extends ConsumerStatefulWidget {
  const ScheduleSortButton({super.key});
  @override
  ConsumerState<ScheduleSortButton> createState() {
    return _ScheduleSortButtonState();
  }
}

class _ScheduleSortButtonState extends ConsumerState<ScheduleSortButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => debugPrint('NO function.'),
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
