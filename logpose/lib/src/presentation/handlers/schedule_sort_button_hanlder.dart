// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/sort/sort_option_provider.dart';

class ScheduleSortButtonHandler {
  ScheduleSortButtonHandler(this.context, this.ref);

  final BuildContext context;
  final WidgetRef ref;

  Future<void> handleToSort() async {
    final currentSort = ref.read(sortOptionProvider);
    if (currentSort == SortOption.byDate) {
      _sortSchedule(SortOption.byGroupNameAndDate);
    } else {
      _sortSchedule(SortOption.byDate);
    }
  }

  void _sortSchedule(SortOption option) {
    ref.read(sortOptionProvider.notifier).state = option;
  }
}
