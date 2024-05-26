import 'package:flutter_riverpod/flutter_riverpod.dart';

/// デフォルトは日付順
final sortOptionProvider =
    StateProvider<SortOption>((ref) => SortOption.byDate);

enum SortOption { byDate, byGroupNameAndDate }
