import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingJudgeProvider = StateProvider<bool>((ref) => false);

void loadingJugeFunc(WidgetRef ref, {required bool judge}) {
  ref.watch(loadingJudgeProvider.notifier).state = judge;
}
