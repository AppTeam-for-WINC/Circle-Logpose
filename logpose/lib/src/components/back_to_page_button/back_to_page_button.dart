import 'package:flutter/cupertino.dart';

class BackToPageButton extends StatelessWidget {
  const BackToPageButton({super.key});

  @override
  Widget build(BuildContext context) {
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
