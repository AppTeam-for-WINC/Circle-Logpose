import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/sort/sort_option_provider.dart';

class ScheduleSortButton extends ConsumerStatefulWidget {
  const ScheduleSortButton({super.key});
  @override
  ConsumerState<ScheduleSortButton> createState() {
    return _ScheduleSortButtonState();
  }
}

class _ScheduleSortButtonState extends ConsumerState<ScheduleSortButton> {
  void _onPressed() {
    final currentSort = ref.read(sortOptionProvider);
    if (currentSort == SortOption.byDate) {
      ref.read(sortOptionProvider.notifier).state =
          SortOption.byGroupNameAndDate;
    } else {
      ref.read(sortOptionProvider.notifier).state = SortOption.byDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: _onPressed,
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
