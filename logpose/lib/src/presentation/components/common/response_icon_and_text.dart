import 'package:flutter/cupertino.dart';

class ResponseIconAndText extends StatelessWidget {
  const ResponseIconAndText({
    super.key,
    required this.responseIcon,
    required this.responseText,
    required this.width,
    required this.height,
    required this.marginTop,
    required this.marginLeft,
  });

  final Icon? responseIcon;
  final Text? responseText;
  final double width;
  final double height;
  final double marginTop;
  final double marginLeft;

  @override
  Widget build(BuildContext context) {
    if (responseIcon == null || responseText == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(top: marginTop, left: marginLeft),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80),
        color: const Color(0xFFFBCEFF),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [responseIcon!, responseText!],
        ),
      ),
    );
  }
}
