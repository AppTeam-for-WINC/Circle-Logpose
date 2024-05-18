import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedGroupNameProvider =
    StateProvider.autoDispose<String>((ref) => 'No selected group');
