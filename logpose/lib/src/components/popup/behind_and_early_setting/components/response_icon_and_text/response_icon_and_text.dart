import 'package:flutter/cupertino.dart';

class ResponseIconAndText extends StatelessWidget {
  const ResponseIconAndText({
    super.key,
    required this.responseIcon,
    required this.responseText,
  });
  final Icon responseIcon;
  final Text responseText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.only(
        top: 100,
        left: 260,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80),
        color: const Color(0xFFFBCEFF),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            responseIcon,
            responseText,
          ],
        ),
      ),
    );
  }
}
