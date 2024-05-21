import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'loading_progress.dart';

class PageProgressIndicator extends ConsumerStatefulWidget {
  const PageProgressIndicator({super.key});

  @override
  ConsumerState createState() => _ProgressIndicatorState();
}

class _ProgressIndicatorState extends ConsumerState<PageProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    if (ref.watch(loadingProgressProvider)) {
      return const Positioned.fill(
        child: Center(
          child: CupertinoActivityIndicator(
            color: Colors.grey,
            radius: 18,
          ),
        ),
      );
    } else {
      return const SizedBox.expand();
    }
  }
}
