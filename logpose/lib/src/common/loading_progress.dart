// ignore_for_file: avoid_setters_without_getters

import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingProgressProvider = StateProvider.autoDispose<bool>((ref) => false);

final loadingErrorMessageProvider =
    StateProvider.autoDispose<String?>((ref) => null);

class LoadingProgressController {
  LoadingProgressController(this.ref);
  final WidgetRef ref;

  set loadingProgress(bool loading) {
    ref.read(loadingProgressProvider.notifier).state = loading;
  }

  set loadingErrorMessage(String? errorMessage) {
    ref.read(loadingErrorMessageProvider.notifier).state = errorMessage;
  }
}
