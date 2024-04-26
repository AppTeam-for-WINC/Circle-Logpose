import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/loading_progress.dart';

class PageProgressIndicator extends ConsumerStatefulWidget {
  const PageProgressIndicator({super.key});

  @override
  ConsumerState createState() => _ProgressIndicatorState();
}

class _ProgressIndicatorState
    extends ConsumerState<PageProgressIndicator> {

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingProgressProvider);
    if (isLoading) {
      return const Positioned.fill(
        child: Center(
          child: CupertinoActivityIndicator(
            color: Colors.grey,
            radius: 18,
          ),
        ),
      );
    } else {
      // Returns an empty widget when not loading.
      return const  SizedBox.expand();
    }
  }
}
