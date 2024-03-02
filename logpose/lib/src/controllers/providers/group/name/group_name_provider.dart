import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupNameProvider =
    StateProvider.autoDispose<String>((ref) => 'No selected group');
