import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingProgressProvider = StateProvider.autoDispose<bool>((ref) => false);
final loadingErrorMessageProvider =
    StateProvider.autoDispose<String?>((ref) => null);

class LoadingProgressController {
  LoadingProgressController._internal();
  static final LoadingProgressController _instance =
      LoadingProgressController._internal();
  static LoadingProgressController get instance => _instance;

  static void loadingProgress(WidgetRef ref, {required bool loading}) {
    ref.watch(loadingProgressProvider.notifier).state = loading;
  }

  static void loadingErrorMessage(WidgetRef ref, String? errorMessage) {
    ref.watch(loadingErrorMessageProvider.notifier).state = errorMessage;
  }
}
