import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackToPageButton extends ConsumerWidget {
  const BackToPageButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onPresseed() {
      Navigator.of(context).pop();
    }

    return CupertinoButton(
      padding: const EdgeInsets.only(left: 15, top: 15),
      onPressed: onPresseed,
      child: const Icon(
        CupertinoIcons.back,
        color: Color(0xFF7B61FF),
      ),
    );
  }
}
