import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthButton extends ConsumerWidget {
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  final Future<void> Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 55,
      width: 195,
      margin: const EdgeInsets.all(23),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        color: const Color.fromRGBO(80, 49, 238, 0.9),
        borderRadius: BorderRadius.circular(30),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Shippori_Mincho_B1',
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
