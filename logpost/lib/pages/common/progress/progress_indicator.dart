import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controller/common/loading_progress.dart';

class PageProgressIndicator extends ConsumerStatefulWidget {
  const PageProgressIndicator({super.key});

  @override
  ConsumerState createState() => _ProgressIndicatorState();
}

class _ProgressIndicatorState
    extends ConsumerState<PageProgressIndicator> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingJudgeProvider);
    if (isLoading) {
      return const Positioned.fill(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    } else {
      // Returns an empty widget when not loading.
      return const SizedBox.shrink();
    }
  }
}
