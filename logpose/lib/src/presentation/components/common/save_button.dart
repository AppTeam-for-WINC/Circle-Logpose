import 'package:flutter/cupertino.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.label, required this.onPressed});

  final String label;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 60,
      margin: const EdgeInsets.only(top: 60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),
        color: const Color(0xFF7B61FF),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(225, 127, 145, 145),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: CupertinoButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Icon(
                CupertinoIcons.check_mark,
                size: 25,
                color: CupertinoColors.white,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                color: CupertinoColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
